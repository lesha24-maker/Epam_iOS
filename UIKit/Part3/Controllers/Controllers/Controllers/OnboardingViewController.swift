//
//  OnboardingViewController.swift
//  Controllers
//
//  Created by Alexey Lim on 19/6/25.
//

// OnboardingViewController.swift

import UIKit

extension Notification.Name {
    static let onboardingDidComplete = Notification.Name("onboardingDidComplete")
}

class OnboardingViewController: UIViewController {

    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome"
        view.backgroundColor = .white
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleOnboardingCompletion), name: .onboardingDidComplete, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupUI() {
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func startButtonTapped() {
        let personalInfoVC = PersonalInfoViewController()
        navigationController?.pushViewController(personalInfoVC, animated: true)
    }
    
    @objc private func handleOnboardingCompletion() {
        startButton.setTitle("Restart", for: .normal)
        startButton.backgroundColor = .systemGreen
    }
}
