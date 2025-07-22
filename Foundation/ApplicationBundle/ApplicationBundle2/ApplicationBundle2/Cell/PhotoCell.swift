//
//  PhotoCell.swift
//  ApplicationBundle2
//
//  Created by Alexey Lim on 22/7/25.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PhotoCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .secondarySystemBackground
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with url: URL) {
        imageView.image = nil
        activityIndicator.startAnimating()
        
        ImageCacheManager.shared.getImage(from: url) { [weak self] result in
            self?.activityIndicator.stopAnimating()
            switch result {
            case .success(let image):
                self?.imageView.image = image
            case .failure(let error):
                print("Error loading image for cell: \(error.localizedDescription)")
            }
        }
    }
}
