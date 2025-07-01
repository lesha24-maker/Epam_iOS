//
//  PhotoCell.swift
//  UICollectionView
//
//  Created by Alexey Lim on 1/7/25.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let identifier = "PhotoCell"
    
    var favoriteButtonTapped: (() -> Void)?
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = .systemGray5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        button.setImage(UIImage(systemName: "heart", withConfiguration: config), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteButton)
        
        favoriteButton.layer.shadowColor = UIColor.black.cgColor
        favoriteButton.layer.shadowRadius = 3
        favoriteButton.layer.shadowOpacity = 0.8
        favoriteButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8),
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    public func configure(with photo: Photo) {
        imageView.image = UIImage(named: photo.imageName)
        titleLabel.text = photo.title
        
        let heartImageName = photo.isFavorite ? "heart.fill" : "heart"
        let heartColor: UIColor = photo.isFavorite ? .systemRed : .white
        
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        favoriteButton.setImage(UIImage(systemName: heartImageName, withConfiguration: config), for: .normal)
        favoriteButton.tintColor = heartColor
    }
    
    @objc private func didTapFavoriteButton() {
        favoriteButtonTapped?()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = .white
    }
}
