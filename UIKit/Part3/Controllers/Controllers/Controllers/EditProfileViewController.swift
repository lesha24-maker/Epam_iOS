//
//  EditProfileViewController.swift
//  Controllers
//
//  Created by Alexey Lim on 20/6/25.
//

import UIKit

class EditProfileViewController: UIViewController {

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the Edit Profile screen."
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EditProfileVC: viewDidLoad")
        view.backgroundColor = .white
        title = "Edit Profile"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("EditProfileVC: viewWillAppear")
        infoLabel.textColor = .purple
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("EditProfileVC: viewDidAppear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("EditProfileVC: viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("EditProfileVC: viewDidLayoutSubviews")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("EditProfileVC: viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("EditProfileVC: viewDidDisappear")
    }
    
    private func setupUI() {
        view.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
