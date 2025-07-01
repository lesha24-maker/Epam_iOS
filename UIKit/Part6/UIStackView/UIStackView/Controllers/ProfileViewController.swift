//
//  ViewController.swift
//  UIStackView
//
//  Created by Alexey Lim on 1/7/25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 80, weight: .light)
        imageView.image = UIImage(systemName: "person.crop.circle.fill", withConfiguration: imageConfig)
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80)
        ])
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Alexey Lim"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var followButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Follow"
        config.baseBackgroundColor = .systemBlue
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20)
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer exploring the world of Swift and UI. I like basketball and I like watching movies. I am a big fan of Apple products. 🎥📱"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var statsStackView: UIStackView = {
        let postsStat = createStatView(value: "312", label: "Posts")
        let followersStat = createStatView(value: "5,041", label: "Followers")
        let followingStat = createStatView(value: "289", label: "Following")
        
        let stackView = UIStackView(arrangedSubviews: [postsStat, followersStat, followingStat])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var taggedPostsSection: UILabel = {
        let label = UILabel()
        label.text = "🖼️ Tagged Posts Section"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.isHidden = true
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 80)
        ])
        return label
    }()
    
    private lazy var toggleSectionButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.title = "Show Tagged Posts"
        config.baseBackgroundColor = .systemIndigo
        config.baseForegroundColor = .systemIndigo
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(didTapToggleSectionButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(mainStackView)
        
        let nameAndButtonStack = UIStackView(arrangedSubviews: [nameLabel, followButton])
        nameAndButtonStack.axis = .vertical
        nameAndButtonStack.spacing = 8
        nameAndButtonStack.alignment = .leading
        
        let headerStack = UIStackView(arrangedSubviews: [profileImageView, nameAndButtonStack])
        headerStack.axis = .horizontal
        headerStack.spacing = 16
        headerStack.alignment = .center
        
        mainStackView.addArrangedSubview(headerStack)
        mainStackView.addArrangedSubview(bioLabel)
        mainStackView.addArrangedSubview(statsStackView)
        
        let separator = createSeparatorView()
        mainStackView.addArrangedSubview(separator)
        mainStackView.setCustomSpacing(32, after: separator)
        
        mainStackView.addArrangedSubview(taggedPostsSection)
        mainStackView.addArrangedSubview(toggleSectionButton)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func createStatView(value: String, label: String) -> UIStackView {
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 18, weight: .bold)
        valueLabel.textAlignment = .center
        
        let textLabel = UILabel()
        textLabel.text = label
        textLabel.font = .systemFont(ofSize: 14)
        textLabel.textColor = .systemGray
        textLabel.textAlignment = .center
        
        let statStack = UIStackView(arrangedSubviews: [valueLabel, textLabel])
        statStack.axis = .vertical
        statStack.spacing = 4
        
        return statStack
    }
    
    private func createSeparatorView() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .systemGray4
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return separator
    }
    
    @objc private func didTapToggleSectionButton() {
        UIView.animate(withDuration: 0.3) {
            self.taggedPostsSection.isHidden.toggle()
            let newTitle = self.taggedPostsSection.isHidden ? "Show Tagged Posts" : "Hide Tagged Posts"
            self.toggleSectionButton.configuration?.title = newTitle
        }
    }
}

