//
//  ViewController.swift
//  Multithreading3
//
//  Created by Alexey Lim on 30/7/25.
//

import UIKit

class OperationCancellationViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let textView = UITextView()
    private let clearButton = UIButton(type: .system)
    
    private let testWithDependencyButton = UIButton(type: .system)
    private let testWithoutDependencyButton = UIButton(type: .system)
    private let cancelAllButton = UIButton(type: .system)
    
    private var currentQueue: OperationQueue?
    private var operationA: CustomBlockOperation?
    private var operationB: CustomBlockOperation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Operation Cancellation Demo"
        
        titleLabel.text = "Operation Cancellation Test\nA cancels B during execution"
        titleLabel.font = .boldSystemFont(ofSize: 20)
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
        
        setupButton(testWithDependencyButton,
                    title: "Test WITH Dependency (B→A)",
                    color: .systemBlue,
                    action: #selector(runTestWithDependency))
        
        setupButton(testWithoutDependencyButton,
                    title: "Test WITHOUT Dependency",
                    color: .systemGreen,
                    action: #selector(runTestWithoutDependency))
        
        setupButton(cancelAllButton,
                    title: "Cancel All Operations",
                    color: .systemRed,
                    action: #selector(cancelAllOperations))
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [titleLabel, textView, clearButton, testWithDependencyButton, testWithoutDependencyButton, cancelAllButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setupButton(_ button: UIButton, title: String, color: UIColor, action: Selector) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
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
            textView.heightAnchor.constraint(equalToConstant: 400),
            
            clearButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10),
            clearButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            clearButton.widthAnchor.constraint(equalToConstant: 120),
            clearButton.heightAnchor.constraint(equalToConstant: 44),
            
            testWithDependencyButton.topAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: 20),
            testWithDependencyButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            testWithDependencyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            testWithDependencyButton.heightAnchor.constraint(equalToConstant: 50),
            
            testWithoutDependencyButton.topAnchor.constraint(equalTo: testWithDependencyButton.bottomAnchor, constant: 15),
            testWithoutDependencyButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            testWithoutDependencyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            testWithoutDependencyButton.heightAnchor.constraint(equalToConstant: 50),
            
            cancelAllButton.topAnchor.constraint(equalTo: testWithoutDependencyButton.bottomAnchor, constant: 30),
            cancelAllButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cancelAllButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cancelAllButton.heightAnchor.constraint(equalToConstant: 50),
            cancelAllButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    @objc private func clearOutput() {
        textView.text = ""
    }
    
    @objc private func cancelAllOperations() {
        currentQueue?.cancelAllOperations()
        logMessage("All operations cancelled manually")
    }
    
    @objc private func runTestWithDependency() {
        logMessage("\n=== TEST WITH DEPENDENCY (B depends on A) ===")
        logMessage("B is declared first, then A")
        logMessage("B.dependencies = [A]")
        logMessage("A will cancel B during its execution")
        
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        currentQueue = operationQueue
        
        operationB = CustomBlockOperation(name: "B") { [weak self] in
            for i in 0..<1000000 {
                if self?.operationB?.isCancelled == true {
                    return
                }
            }
        }
        
        operationA = CustomBlockOperation(name: "A") { [weak self] in
            for i in 0..<1000000 {
                if self?.operationA?.isCancelled == true {
                    return
                }
                
                if i == 500000 {
                    DispatchQueue.main.async {
                        self?.logMessage("Operation A is cancelling Operation B")
                    }
                    self?.operationB?.cancel()
                }
            }
        }
        
        operationA?.onStatusUpdate = { [weak self] message in
            self?.logMessage(message)
        }
        
        operationB?.onStatusUpdate = { [weak self] message in
            self?.logMessage(message)
        }
        
        operationB?.addDependency(operationA!)
        
        logMessage("Adding operations to queue...")
        operationQueue.addOperations([operationA!, operationB!], waitUntilFinished: false)
        
        operationQueue.addBarrierBlock {
            DispatchQueue.main.async {
                self.logMessage("=== TEST WITH DEPENDENCY COMPLETED ===\n")
            }
        }
    }
    
    @objc private func runTestWithoutDependency() {
        logMessage("\n=== TEST WITHOUT DEPENDENCY ===")
        logMessage("B is declared first, then A")
        logMessage("No dependencies between operations")
        logMessage("A will cancel B during its execution")
        
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        currentQueue = operationQueue
        
        operationB = CustomBlockOperation(name: "B") { [weak self] in
            for i in 0..<1000000 {
                if self?.operationB?.isCancelled == true {
                    return
                }
            }
        }
        
        operationA = CustomBlockOperation(name: "A") { [weak self] in
            for i in 0..<1000000 {
                if self?.operationA?.isCancelled == true {
                    return
                }
                
                if i == 500000 {
                    DispatchQueue.main.async {
                        self?.logMessage("🎯 Operation A is cancelling Operation B")
                    }
                    self?.operationB?.cancel()
                }
            }
        }
        
        operationA?.onStatusUpdate = { [weak self] message in
            self?.logMessage(message)
        }
        
        operationB?.onStatusUpdate = { [weak self] message in
            self?.logMessage(message)
        }
        
        logMessage("Adding operations to queue...")
        operationQueue.addOperations([operationA!, operationB!], waitUntilFinished: false)
        
        operationQueue.addBarrierBlock {
            DispatchQueue.main.async {
                self.logMessage("=== TEST WITHOUT DEPENDENCY COMPLETED ===\n")
            }
        }
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
