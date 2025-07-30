//
//  ViewController.swift
//  Multithreading2
//
//  Created by Alexey Lim on 30/7/25.
//

import UIKit

class OperationQueueViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let textView = UITextView()
    private let clearButton = UIButton(type: .system)
    
    private let test1Button = UIButton(type: .system)
    private let test2Button = UIButton(type: .system)
    private let test3Button = UIButton(type: .system)
    private let test4Button = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)
    
    private var currentQueue: OperationQueue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "NSOperationQueue Demo"
        
        titleLabel.text = "Operation Queue Concurrency Tests"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 8
        textView.font = .monospacedSystemFont(ofSize: 12, weight: .regular)
        textView.isEditable = false
        textView.text = "Tap a test button to start...\n"
        
        clearButton.setTitle("Clear Output", for: .normal)
        clearButton.backgroundColor = .systemGray4
        clearButton.setTitleColor(.label, for: .normal)
        clearButton.layer.cornerRadius = 8
        clearButton.addTarget(self, action: #selector(clearOutput), for: .touchUpInside)
        
        setupButton(test1Button, title: "Test 1: Max 6 Concurrent", action: #selector(runTest1))
        setupButton(test2Button, title: "Test 2: Max 2 Concurrent", action: #selector(runTest2))
        setupButton(test3Button, title: "Test 3: With Dependencies", action: #selector(runTest3))
        setupButton(test4Button, title: "Test 4: Low Priority A", action: #selector(runTest4))
        
        cancelButton.setTitle("Cancel All Operations", for: .normal)
        cancelButton.backgroundColor = .systemRed
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.layer.cornerRadius = 8
        cancelButton.addTarget(self, action: #selector(cancelAllOperations), for: .touchUpInside)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [titleLabel, textView, clearButton, test1Button, test2Button, test3Button, test4Button, cancelButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setupButton(_ button: UIButton, title: String, action: Selector) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 300),
            
            clearButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10),
            clearButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            clearButton.widthAnchor.constraint(equalToConstant: 120),
            clearButton.heightAnchor.constraint(equalToConstant: 44),
            
            test1Button.topAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: 20),
            test1Button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            test1Button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            test1Button.heightAnchor.constraint(equalToConstant: 50),
            
            test2Button.topAnchor.constraint(equalTo: test1Button.bottomAnchor, constant: 15),
            test2Button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            test2Button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            test2Button.heightAnchor.constraint(equalToConstant: 50),
            
            test3Button.topAnchor.constraint(equalTo: test2Button.bottomAnchor, constant: 15),
            test3Button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            test3Button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            test3Button.heightAnchor.constraint(equalToConstant: 50),
            
            test4Button.topAnchor.constraint(equalTo: test3Button.bottomAnchor, constant: 15),
            test4Button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            test4Button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            test4Button.heightAnchor.constraint(equalToConstant: 50),
            
            cancelButton.topAnchor.constraint(equalTo: test4Button.bottomAnchor, constant: 30),
            cancelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    @objc private func clearOutput() {
        textView.text = ""
    }
    
    @objc private func cancelAllOperations() {
        currentQueue?.cancelAllOperations()
        logMessage("All operations cancelled")
    }
    
    @objc private func runTest1() {
        logMessage("\n=== TEST 1: maxConcurrentOperationCount = 6 ===")
        
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 6
        currentQueue = operationQueue
        
        let operations = createOperations()
        
        operationQueue.addOperations(operations, waitUntilFinished: false)
        
        operationQueue.addBarrierBlock {
            DispatchQueue.main.async {
                self.logMessage("=== TEST 1 COMPLETED ===\n")
            }
        }
    }
    
    @objc private func runTest2() {
        logMessage("\n=== TEST 2: maxConcurrentOperationCount = 2 ===")
        
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        currentQueue = operationQueue
        
        let operations = createOperations()
        
        operationQueue.addOperations(operations, waitUntilFinished: false)
        
        operationQueue.addBarrierBlock {
            DispatchQueue.main.async {
                self.logMessage("=== TEST 2 COMPLETED ===\n")
            }
        }
    }
    
    @objc private func runTest3() {
        logMessage("\n=== TEST 3: With Dependencies (B→C, D→B) ===")
        
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        currentQueue = operationQueue
        
        let operations = createOperations()
        let operationA = operations[0]
        let operationB = operations[1]
        let operationC = operations[2]
        let operationD = operations[3]
        
        operationB.addDependency(operationC)
        operationD.addDependency(operationB)
        
        logMessage("Dependencies set: B depends on C, D depends on B")
        
        operationQueue.addOperations(operations, waitUntilFinished: false)
        
        operationQueue.addBarrierBlock {
            DispatchQueue.main.async {
                self.logMessage("=== TEST 3 COMPLETED ===\n")
            }
        }
    }
    
    @objc private func runTest4() {
        logMessage("\n=== TEST 4: Operation A with Low Priority ===")
        
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        currentQueue = operationQueue
        
        let operations = createOperations()
        let operationA = operations[0]
        let operationB = operations[1]
        let operationC = operations[2]
        let operationD = operations[3]
        
        operationB.addDependency(operationC)
        operationD.addDependency(operationB)
        
        operationA.queuePriority = .low
        
        logMessage("Dependencies set: B depends on C, D depends on B")
        logMessage("Operation A priority set to LOW")
        
        operationQueue.addOperations(operations, waitUntilFinished: false)
        
        operationQueue.addBarrierBlock {
            DispatchQueue.main.async {
                self.logMessage("=== TEST 4 COMPLETED ===\n")
            }
        }
    }
    
    private func createOperations() -> [LongRunningOperation] {
        let operations = ["A", "B", "C", "D"].map { name -> LongRunningOperation in
            let operation = LongRunningOperation(name: name)
            operation.onStatusUpdate = { [weak self] message in
                self?.logMessage(message)
            }
            return operation
        }
        return operations
    }
    
    private func logMessage(_ message: String) {
        let timestamp = DateFormatter().apply {
            $0.dateFormat = "HH:mm:ss.SSS"
        }.string(from: Date())
        
        let logEntry = "[\(timestamp)] \(message)\n"
        textView.text += logEntry
        
        let bottom = NSMakeRange(textView.text.count - 1, 1)
        textView.scrollRangeToVisible(bottom)
    }
}

extension DateFormatter {
    func apply(_ closure: (DateFormatter) -> Void) -> DateFormatter {
        closure(self)
        return self
    }
}

