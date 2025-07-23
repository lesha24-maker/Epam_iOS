//
//  MainViewController.swift
//  UserDefaults2
//
//  Created by Alexey Lim on 23/7/25.
//

import UIKit

class MainViewController: UIViewController {

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.title = "Log Out"
        config.baseForegroundColor = .systemRed
        let button = UIButton(configuration: config, primaryAction: UIAction { [unowned self] _ in
            self.handleLogout()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayUserInfo()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Main Screen"
        
        view.addSubview(welcomeLabel)
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func displayUserInfo() {
        if let email = SessionManager.shared.getUserEmail() {
            welcomeLabel.text = "Welcome,\n\(email)"
        }
    }
    
    private func handleLogout() {
        SessionManager.shared.logout()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.showLoginScreen()
    }
}
