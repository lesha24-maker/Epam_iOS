//
//  ViewController.swift
//  ApplicationBundle2
//
//  Created by Alexey Lim on 18/7/25.
//

import UIKit

class ViewController: UIViewController {

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .secondarySystemBackground
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var fetchImageButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Fetch New Image"
        config.baseBackgroundColor = .systemBlue
        config.cornerStyle = .medium
        
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(fetchImageButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var clearCacheButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.title = "Clear Cache"
        config.baseBackgroundColor = .systemRed
        config.baseForegroundColor = .systemRed
        config.cornerStyle = .medium
        
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(clearCacheButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchImageButtonTapped()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(fetchImageButton)
        view.addSubview(clearCacheButton)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

            fetchImageButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            fetchImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fetchImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fetchImageButton.heightAnchor.constraint(equalToConstant: 50),
            
            clearCacheButton.topAnchor.constraint(equalTo: fetchImageButton.bottomAnchor, constant: 12),
            clearCacheButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            clearCacheButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            clearCacheButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func fetchImageButtonTapped() {
        guard let imageURL = URL(string: "https://picsum.photos/400/400?random=\(Int.random(in: 1...1000))") else { return }
        
        imageView.image = nil
        
        ImageCacheManager.shared.getImage(from: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                self?.imageView.image = image
            case .failure(let error):
                print("Error loading image: \(error.localizedDescription)")
            }
        }
    }

    @objc private func clearCacheButtonTapped() {
        ImageCacheManager.shared.manualClearCache()
        
        let alert = UIAlertController(title: "Cache Cleared", message: "The image cache has been deleted.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
