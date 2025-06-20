//
//  ConfirmDetailsViewController.swift
//  Controllers
//
//  Created by Alexey Lim on 20/6/25.
//

import UIKit

class ConfirmDetailsViewController: UIViewController {

    private let name: String
    private let phone: String
    private let preference: String
    
    private lazy var nameLabel: UILabel = createSummaryLabel(title: "Name", detail: name)
    private lazy var phoneLabel: UILabel = createSummaryLabel(title: "Phone Number", detail: phone)
    private lazy var preferenceLabel: UILabel = createSummaryLabel(title: "Notification Preference", detail: preference)
    
    private lazy var editPersonalInfoButton: UIButton = createNavButton(
        title: "Edit personal info",
        color: .systemOrange,
        action: #selector(editPersonalInfoTapped)
    )
    
    private lazy var editPreferencesButton: UIButton = createNavButton(
        title: "Edit preferences",
        color: .systemOrange,
        action: #selector(editPreferencesTapped)
    )
    
    private lazy var startOverButton: UIButton = createNavButton(
        title: "Start over",
        color: .systemRed,
        action: #selector(startOverTapped)
    )
    
    private lazy var confirmButton: UIButton = createNavButton(
        title: "Confirm",
        color: .systemGreen,
        action: #selector(confirmTapped)
    )
    
    init(name: String, phone: String, preference: String) {
        self.name = name
        self.phone = phone
        self.preference = preference
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Confirmation"
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        setupUI()
    }
        
    private func createSummaryLabel(title: String, detail: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = "\(title): \(detail)"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func createNavButton(title: String, color: UIColor, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(phoneLabel)
        view.addSubview(preferenceLabel)
        
        view.addSubview(confirmButton)
        view.addSubview(startOverButton)
        view.addSubview(editPreferencesButton)
        view.addSubview(editPersonalInfoButton)
        
        let horizontalPadding: CGFloat = 30
        let verticalSpacing: CGFloat = 12
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),

            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: verticalSpacing),
            phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            preferenceLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: verticalSpacing),
            preferenceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            preferenceLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
        ])
 
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 15
        
        NSLayoutConstraint.activate([
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            confirmButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            startOverButton.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -buttonSpacing),
            startOverButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startOverButton.widthAnchor.constraint(equalTo: confirmButton.widthAnchor),
            startOverButton.heightAnchor.constraint(equalTo: confirmButton.heightAnchor),
            
            editPreferencesButton.bottomAnchor.constraint(equalTo: startOverButton.topAnchor, constant: -buttonSpacing),
            editPreferencesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editPreferencesButton.widthAnchor.constraint(equalTo: confirmButton.widthAnchor),
            editPreferencesButton.heightAnchor.constraint(equalTo: confirmButton.heightAnchor),
            
            editPersonalInfoButton.bottomAnchor.constraint(equalTo: editPreferencesButton.topAnchor, constant: -buttonSpacing),
            editPersonalInfoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editPersonalInfoButton.widthAnchor.constraint(equalTo: confirmButton.widthAnchor),
            editPersonalInfoButton.heightAnchor.constraint(equalTo: confirmButton.heightAnchor),
            
            editPersonalInfoButton.topAnchor.constraint(greaterThanOrEqualTo: preferenceLabel.bottomAnchor, constant: 40)
        ])
    }
    
    @objc private func startOverTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func editPreferencesTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func editPersonalInfoTapped() {
        if let personalInfoVC = navigationController?.viewControllers.first(where: { $0 is PersonalInfoViewController }) {
            navigationController?.popToViewController(personalInfoVC, animated: true)
        }
    }
    
    @objc private func confirmTapped() {
        let alert = UIAlertController(title: "Success!", message: "You have successfully passed the onboarding.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            NotificationCenter.default.post(name: .onboardingDidComplete, object: nil)
            self?.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
