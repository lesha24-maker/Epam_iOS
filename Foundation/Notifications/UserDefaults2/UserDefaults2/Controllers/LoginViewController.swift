//
//  ViewController.swift
//  UserDefaults2
//
//  Created by Alexey Lim on 23/7/25.
//

import UIKit

class LoginViewController: UIViewController {

    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter your email"
        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var loginButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Log In"
        let button = UIButton(configuration: config, primaryAction: UIAction { [unowned self] _ in
            self.handleLogin()
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
        title = "Login"
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }

    private func handleLogin() {
        guard let email = emailTextField.text, !email.isEmpty else {
            return
        }
        
        SessionManager.shared.login(with: email)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.showMainScreen()
    }
}
