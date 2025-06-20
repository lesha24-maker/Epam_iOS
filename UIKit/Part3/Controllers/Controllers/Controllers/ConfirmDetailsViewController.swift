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

    private lazy var summaryStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
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
        return label
    }

    private func createNavButton(title: String, color: UIColor, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    private func setupUI() {
        // Setup Summary
        summaryStackView.addArrangedSubview(createSummaryLabel(title: "Name", detail: name))
        summaryStackView.addArrangedSubview(createSummaryLabel(title: "Phone Number", detail: phone))
        summaryStackView.addArrangedSubview(createSummaryLabel(title: "Notification Preference", detail: preference))
        
        // Setup Buttons
        buttonStackView.addArrangedSubview(createNavButton(title: "Edit personal info", color: .systemOrange, action: #selector(editPersonalInfoTapped)))
        buttonStackView.addArrangedSubview(createNavButton(title: "Edit preferences", color: .systemOrange, action: #selector(editPreferencesTapped)))
        buttonStackView.addArrangedSubview(createNavButton(title: "Start over", color: .systemRed, action: #selector(startOverTapped)))
        buttonStackView.addArrangedSubview(createNavButton(title: "Confirm", color: .systemGreen, action: #selector(confirmTapped)))

        view.addSubview(summaryStackView)
        view.addSubview(buttonStackView)

        NSLayoutConstraint.activate([
            summaryStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            summaryStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            summaryStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            buttonStackView.topAnchor.constraint(greaterThanOrEqualTo: summaryStackView.bottomAnchor, constant: 40),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            buttonStackView.heightAnchor.constraint(equalToConstant: 230) // 4 * 50 (button height) + 3 * 10 (spacing)
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
