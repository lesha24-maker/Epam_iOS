//
//  PreferencesViewController.swift
//  Controllers
//
//  Created by Alexey Lim on 20/6/25.
//

import UIKit

class PreferencesViewController: UIViewController {
    
    private let name: String
    private let phone: String
    private var selectedPreference: String? {
        didSet {
            if let preference = selectedPreference {
                preferenceLabel.text = "Selected: \(preference)"
                continueButton.isEnabled = true
                continueButton.backgroundColor = .systemBlue
            }
        }
    }
    
    private lazy var selectPreferenceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Choose Notification Preference", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.backgroundColor = .systemGray5
        button.tintColor = .label
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showPreferenceOptions), for: .touchUpInside)
        return button
    }()
    
    private lazy var preferenceLabel: UILabel = {
        let label = UILabel()
        label.text = "Selected: None"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemGray
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        return button
    }()
    
    init(name: String, phone: String) {
        self.name = name
        self.phone = phone
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Preferences"
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(selectPreferenceButton)
        view.addSubview(preferenceLabel)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            selectPreferenceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectPreferenceButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            selectPreferenceButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            selectPreferenceButton.heightAnchor.constraint(equalToConstant: 50),
            
            preferenceLabel.topAnchor.constraint(equalTo: selectPreferenceButton.bottomAnchor, constant: 20),
            preferenceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            preferenceLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func showPreferenceOptions() {
        let actionSheet = UIAlertController(title: "Select Notification Preference", message: nil, preferredStyle: .actionSheet)
        
        let options = ["Email Notifications", "SMS Notifications", "Push Notifications"]
        
        options.forEach { option in
            let action = UIAlertAction(title: option, style: .default) { [weak self] _ in
                self?.selectedPreference = option
            }
            actionSheet.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true)
    }
    
    @objc private func continueTapped() {
        guard let preference = selectedPreference else { return }
        let confirmVC = ConfirmDetailsViewController(name: name, phone: phone, preference: preference)
        navigationController?.pushViewController(confirmVC, animated: true)
    }
}
