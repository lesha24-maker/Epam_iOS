//
//  ViewController.swift
//  ApplicationBundle3
//
//  Created by Alexey Lim on 18/7/25.
//

import UIKit

class ViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 20
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        
        if let config: AppConfig = loadConfiguration(from: "config") {apply(configuration: config)
        } else {
            displayError("Could not load or parse configuration.")
        }
    }
    
    private func loadConfiguration<T: Decodable>(from filename: String) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Error: Could not find \(filename).json in the bundle.")
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("Error: Could not load data from \(url).")
            return nil
        }
        
        let decoder = JSONDecoder()
        guard let loadedConfig = try? decoder.decode(T.self, from: data) else {
            print("Error: Failed to decode \(filename).json.")
            return nil
        }
        
        return loadedConfig
    }
    
    private func loadBundledImage(named name: String) -> UIImage? {
        let image = UIImage(named: name)
        if image == nil {
            print("Warning: Image asset named '\(name)' not found.")
        }
        return image
    }
    
    private func apply(configuration: AppConfig) {
        self.title = configuration.screenTitle
        
        for imageConfig in configuration.imagesToShow {
            
            let imageContainer = UIView()
            
            let imageView = UIImageView()
            imageView.image = loadBundledImage(named: imageConfig.name)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            if configuration.displayImageBorder {
                imageView.layer.borderWidth = 2.0
                imageView.layer.borderColor = UIColor(hex: configuration.borderColorHex)?.cgColor
                imageView.layer.cornerRadius = 8
            }
            
            let captionLabel = UILabel()
            captionLabel.text = imageConfig.caption
            captionLabel.font = .systemFont(ofSize: 14, weight: .medium)
            captionLabel.textAlignment = .center
            captionLabel.translatesAutoresizingMaskIntoConstraints = false
            
            imageContainer.addSubview(imageView)
            imageContainer.addSubview(captionLabel)
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor, constant: 10),
                imageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: -10),
                imageView.heightAnchor.constraint(equalToConstant: 150),
                
                captionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
                captionLabel.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
                captionLabel.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
                captionLabel.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor)
            ])
            
            stackView.addArrangedSubview(imageContainer)
        }
    }
    
    private func displayError(_ message: String) {
        let label = UILabel()
        label.text = message
        label.textColor = .red
        label.textAlignment = .center
        stackView.addArrangedSubview(label)
    }
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b: CGFloat
        let start = hex.hasPrefix("#") ? hex.index(hex.startIndex, offsetBy: 1) : hex.startIndex
        let hexColor = String(hex[start...])
        
        if hexColor.count == 6 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                b = CGFloat(hexNumber & 0x0000ff) / 255
                self.init(red: r, green: g, blue: b, alpha: 1.0)
                return
            }
        }
        return nil
    }
}
