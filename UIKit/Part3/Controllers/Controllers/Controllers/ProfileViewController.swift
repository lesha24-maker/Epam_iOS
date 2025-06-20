//
//  ProfileViewController.swift
//  Controllers
//
//  Created by Alexey Lim on 19/6/25.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Default Name"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.addTarget(self, action: #selector(editProfileTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ProfileVC: viewDidLoad")
        view.backgroundColor = .systemGroupedBackground
        title = "Profile"
        setupNavBar()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ProfileVC: viewWillAppear")
        nameLabel.textColor = .blue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ProfileVC: viewDidAppear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("ProfileVC: viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("ProfileVC: viewDidLayoutSubviews")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ProfileVC: viewWillDisappear")
        nameLabel.textColor = .black // Reset color
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ProfileVC: viewDidDisappear")
    }

    private func setupNavBar() {
        let editNameButton = UIBarButtonItem(image: UIImage(systemName: "pencil.slash"), style: .plain, target: self, action: #selector(editNameTapped))
        let anonymousButton = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.fill"), style: .plain, target: self, action: #selector(setAnonymousTapped))
        navigationItem.rightBarButtonItems = [editNameButton, anonymousButton]
    }
    
    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(editProfileButton)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            editProfileButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            editProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func editProfileTapped() {
        let editProfileVC = EditProfileViewController()
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    @objc private func setAnonymousTapped() {
        nameLabel.text = "Anonymous"
    }
    
    @objc private func editNameTapped() {
        let alert = UIAlertController(title: "Edit Name", message: "Enter a new name.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "New Name"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self, weak alert] _ in
            guard let textField = alert?.textFields?.first, let newName = textField.text else { return }
            if newName.trimmingCharacters(in: .whitespaces).isEmpty {
                self?.nameLabel.text = "Default"
            } else {
                self?.nameLabel.text = newName
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
