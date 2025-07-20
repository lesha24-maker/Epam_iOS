//
//  ReceiverViewController.swift
//  Notifications1
//
//  Created by Alexey Lim on 20/7/25.
//

import UIKit

class ReceiverViewController: UIViewController {

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for notification..."
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addNotificationObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("✅ ReceiverViewController deinitialized and observer removed.")
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Receiver"
        
        view.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
        
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification),
            name: .didRequestDataUpdate,
            object: nil
        )
    }
    
    @objc private func handleNotification() {
        statusLabel.text = "Notification Received!\n\(Date().formatted(date: .omitted, time: .standard))"
        statusLabel.textColor = .systemGreen
        statusLabel.numberOfLines = 0
    }
}
