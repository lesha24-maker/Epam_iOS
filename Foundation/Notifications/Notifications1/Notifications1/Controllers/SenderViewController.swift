//
//  ViewController.swift
//  Notifications1
//
//  Created by Alexey Lim on 20/7/25.
//

import UIKit

class SenderViewController: UIViewController {

    private lazy var postNotificationButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Post Notification"
        config.baseBackgroundColor = .systemBlue
        config.cornerStyle = .medium
        
        let button = UIButton(configuration: config, primaryAction: UIAction { [unowned self] _ in
            self.postNotification()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Sender"
        
        view.addSubview(postNotificationButton)
        
        NSLayoutConstraint.activate([
            postNotificationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postNotificationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            postNotificationButton.widthAnchor.constraint(equalToConstant: 200),
            postNotificationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func postNotification() {
        NotificationCenter.default.post(name: .didRequestDataUpdate, object: nil)
        
        let alert = UIAlertController(title: "Posted!", message: "Notification 'didRequestDataUpdate' has been sent.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
