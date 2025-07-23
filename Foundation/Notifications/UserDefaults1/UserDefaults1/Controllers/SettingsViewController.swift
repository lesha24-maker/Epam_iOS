//
//  ViewController.swift
//  UserDefaults1
//
//  Created by Alexey Lim on 23/7/25.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let themeLabel: UILabel = {
        let label = UILabel()
        label.text = "App Theme"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var themeSegmentedControl: UISegmentedControl = {
        let items = ["Light", "Dark", "System"]
        let sc = UISegmentedControl(items: items)
        sc.addTarget(self, action: #selector(themeChanged), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadCurrentTheme()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Settings"
        
        view.addSubview(themeLabel)
        view.addSubview(themeSegmentedControl)
        
        NSLayoutConstraint.activate([
            themeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            themeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            themeSegmentedControl.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: 12),
            themeSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            themeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func loadCurrentTheme() {
        let currentTheme = ThemeManager.shared.getCurrentTheme()
        themeSegmentedControl.selectedSegmentIndex = currentTheme.rawValue
    }

    @objc private func themeChanged(_ sender: UISegmentedControl) {
        guard let selectedTheme = ThemeManager.Theme(rawValue: sender.selectedSegmentIndex) else { return }
        
        ThemeManager.shared.setTheme(selectedTheme)
    }
}
