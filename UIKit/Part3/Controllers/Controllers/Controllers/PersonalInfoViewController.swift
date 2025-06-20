//
//  PersonalInfoViewController.swift
//  Controllers
//
//  Created by Alexey Lim on 19/6/25.
//

import UIKit

class PersonalInfoViewController: UIViewController {
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Please, enter your name"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Please, enter your phone number"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Personal Info"
        view.backgroundColor = .white
        setupUI()
        setupActions()
        updateConfirmButtonState()
    }
    
    private func setupUI() {
        view.addSubview(nameTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            phoneNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneNumberTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 44),
            
            confirmButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 30),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupActions() {
        nameTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        phoneNumberTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldsDidChange() {
        updateConfirmButtonState()
    }
    
    private func updateConfirmButtonState() {
        let isNameValid = !(nameTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isPhoneValid = (phoneNumberTextField.text?.count ?? 0) >= 9
        let isEnabled = isNameValid && isPhoneValid
        
        confirmButton.isEnabled = isEnabled
        confirmButton.backgroundColor = isEnabled ? .systemBlue : .systemGray
    }
    
    @objc private func confirmTapped() {
        let name = nameTextField.text ?? ""
        let phone = phoneNumberTextField.text ?? ""
        
        let alert = UIAlertController(
            title: "Confirm Information",
            message: "Please confirm your name and phone number.\nName: \(name)\nPhone: \(phone)",
            preferredStyle: .alert
        )
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            let preferencesVC = PreferencesViewController(name: name, phone: phone)
            self?.navigationController?.pushViewController(preferencesVC, animated: true)
        }
        
        let editAction = UIAlertAction(title: "Edit", style: .cancel)
        
        alert.addAction(confirmAction)
        alert.addAction(editAction)
        present(alert, animated: true)
    }
}
