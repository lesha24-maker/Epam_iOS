//
//  Task2.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit

// Build a UI programmatically with a UIButton positioned below a UILabel.
// The button should be centered horizontally and have a fixed distance from the label.
// Adjust the layout to handle different screen sizes.
final class Task2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        let label = UILabel()
        label.text = "EPAM iOS!"
        label.font = .systemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints  = false
        
        let button = UIButton(type: .system)
        button.setTitle("TAP ME", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints  = false
       
        view.addSubview(label)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 44),
            button.widthAnchor.constraint(equalToConstant: 120),
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

#Preview {
    Task2ViewController()
}
