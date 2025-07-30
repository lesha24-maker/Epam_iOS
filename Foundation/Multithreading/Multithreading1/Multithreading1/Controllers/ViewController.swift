//
//  ViewController.swift
//  Multithreading1
//
//  Created by Alexey Lim on 29/7/25.
//

import UIKit

class ViewController: UIViewController {

    let customOperationQueue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let runOnMainQueueButton = UIButton(type: .system)
        runOnMainQueueButton.setTitle("Run on Main Queue", for: .normal)
        runOnMainQueueButton.addTarget(self, action: #selector(runOperationOnMainQueue), for: .touchUpInside)

        let runOnCustomQueueButton = UIButton(type: .system)
        runOnCustomQueueButton.setTitle("Run on Custom Queue", for: .normal)
        runOnCustomQueueButton.addTarget(self, action: #selector(runOperationOnCustomQueue), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [runOnMainQueueButton, runOnCustomQueueButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func runOperationOnMainQueue() {
        let operationA = BlockOperation {
            print("Operation \"A\" started on main queue")
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \"A\" finished on main queue")
        }

        OperationQueue.main.addOperation(operationA)
    }

    @objc func runOperationOnCustomQueue() {
        let operationA = BlockOperation {
            print("Operation \"A\" started on custom queue")
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \"A\" finished on custom queue")
        }

        customOperationQueue.addOperation(operationA)
    }
}

