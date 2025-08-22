//
//  ViewController.swift
//  EnvironmentObjects3
//
//  Created by Alexey Lim on 22/8/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        let showSwiftUIButton = UIButton(type: .system)
        showSwiftUIButton.setTitle("Show SwiftUI View", for: .normal)
        showSwiftUIButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        
        showSwiftUIButton.addTarget(self, action: #selector(showSwiftUIViewTapped), for: .touchUpInside)
        
        self.view.addSubview(showSwiftUIButton)
        
        showSwiftUIButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showSwiftUIButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            showSwiftUIButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    @objc func showSwiftUIViewTapped() {
        let swiftUIView = HostedSwiftUIView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        present(hostingController, animated: true)
    }
}
