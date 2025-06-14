//
//  Task4ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//
import UIKit
// Create a view with two subviews aligned vertically when in Compact width, Regular height mode.
// If the orientation changes to Compact-Compact, same 2 subviews should be aligned horizontally.
// You can use iPhone 16 simulator for testing.
final class Task4ViewController: UIViewController {
    
    private let firstView = UIView()
    private let secondView = UIView()
    
    private var verticalConstraints: [NSLayoutConstraint] = []
    private var horizontalConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        updateLayoutForCurrentTraitCollection()
        registerForTraitChanges()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        firstView.backgroundColor = .systemBlue
        firstView.layer.cornerRadius = 12
        firstView.translatesAutoresizingMaskIntoConstraints = false
        
        secondView.backgroundColor = .systemGreen
        secondView.layer.cornerRadius = 12
        secondView.translatesAutoresizingMaskIntoConstraints = false
        
        let firstLabel = UILabel()
        firstLabel.text = "First View"
        firstLabel.textColor = .white
        firstLabel.font = .boldSystemFont(ofSize: 18)
        firstLabel.textAlignment = .center
        firstLabel.numberOfLines = 1
        firstLabel.lineBreakMode = .byTruncatingTail
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let secondLabel = UILabel()
        secondLabel.text = "Second View"
        secondLabel.textColor = .white
        secondLabel.font = .boldSystemFont(ofSize: 18)
        secondLabel.textAlignment = .center
        secondLabel.numberOfLines = 1
        secondLabel.lineBreakMode = .byTruncatingTail
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(firstView)
        view.addSubview(secondView)
        firstView.addSubview(firstLabel)
        secondView.addSubview(secondLabel)
        
        NSLayoutConstraint.activate([
            firstLabel.centerXAnchor.constraint(equalTo: firstView.centerXAnchor),
            firstLabel.centerYAnchor.constraint(equalTo: firstView.centerYAnchor),
            firstLabel.leadingAnchor.constraint(greaterThanOrEqualTo: firstView.leadingAnchor, constant: 8),
            firstLabel.trailingAnchor.constraint(lessThanOrEqualTo: firstView.trailingAnchor, constant: -8),
            
            secondLabel.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            secondLabel.centerYAnchor.constraint(equalTo: secondView.centerYAnchor),
            secondLabel.leadingAnchor.constraint(greaterThanOrEqualTo: secondView.leadingAnchor, constant: 8),
            secondLabel.trailingAnchor.constraint(lessThanOrEqualTo: secondView.trailingAnchor, constant: -8)
        ])
    }
    
    private func setupConstraints() {
        verticalConstraints = [
            firstView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            firstView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstView.heightAnchor.constraint(equalToConstant: 200),
            
            secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: 20),
            secondView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            secondView.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        horizontalConstraints = [
            firstView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            firstView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            firstView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            
            secondView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            secondView.leadingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: 20),
            secondView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            secondView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ]
    }
    
    private func updateLayoutForCurrentTraitCollection() {
        NSLayoutConstraint.deactivate(verticalConstraints)
        NSLayoutConstraint.deactivate(horizontalConstraints)
        
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            NSLayoutConstraint.activate(verticalConstraints)
        } else if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .compact {
            NSLayoutConstraint.activate(horizontalConstraints)
        } else {
            NSLayoutConstraint.activate(verticalConstraints)
        }
    }
    
    private func registerForTraitChanges() {
        let sizeTraits: [UITrait] = [UITraitVerticalSizeClass.self, UITraitHorizontalSizeClass.self]
        registerForTraitChanges(sizeTraits) { (self: Self, previousTraitCollection: UITraitCollection) in
            self.updateLayoutForCurrentTraitCollection()
        }
    }
}

#Preview {
    Task4ViewController()
}
