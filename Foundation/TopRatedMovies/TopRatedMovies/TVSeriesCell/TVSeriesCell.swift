//
//  TVSeriesCell.swift
//  TopRatedMovies
//
//  Created by Alexey Lim on 9/7/25.
//

import UIKit

class TVSeriesCell: UITableViewCell {

    static let identifier = "TVSeriesCell"
    private let imageBaseURL = "https://image.tmdb.org/t/p/w500"

    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "image_placeholder")
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        return label
    }()

    private let firstAirDateLabel = UILabel(font: .systemFont(ofSize: 14), color: .darkGray)
    private let ratingLabel = UILabel(font: .systemFont(ofSize: 14), color: .darkGray)
    private let countriesLabel = UILabel(font: .systemFont(ofSize: 14), color: .darkGray)
    private let popularityLabel = UILabel(font: .systemFont(ofSize: 14), color: .darkGray)

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let infoStackView = UIStackView(arrangedSubviews: [titleLabel, firstAirDateLabel, ratingLabel, countriesLabel, popularityLabel])
        infoStackView.axis = .vertical
        infoStackView.spacing = 4
        
        let topStackView = UIStackView(arrangedSubviews: [posterImageView, infoStackView])
        topStackView.axis = .horizontal
        topStackView.spacing = 16
        topStackView.alignment = .top
        
        let mainStackView = UIStackView(arrangedSubviews: [topStackView, overviewLabel])
        mainStackView.axis = .vertical
        mainStackView.spacing = 12
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            posterImageView.widthAnchor.constraint(equalToConstant: 120),
            posterImageView.heightAnchor.constraint(equalToConstant: 180),
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    public func configure(with series: TVSeries) {
        titleLabel.text = series.name
        firstAirDateLabel.text = "First Air Date - \(series.firstAirDate)"
        ratingLabel.text = "Rating - \(series.voteAverage)"
        countriesLabel.text = "Countries - \(series.originCountry.joined(separator: ", "))"
        popularityLabel.text = "Popularity - \(Int(series.popularity))"
        overviewLabel.text = series.overview
        
        posterImageView.image = UIImage(named: "image_placeholder")
        
        if let posterPath = series.posterPath {
            let fullImageURL = URL(string: imageBaseURL + posterPath)
            loadImage(from: fullImageURL)
        }
    }
    
    private func loadImage(from url: URL?) {
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.posterImageView.image = image
                }
            }
        }.resume()
    }
}

extension UILabel {
    convenience init(font: UIFont, color: UIColor) {
        self.init()
        self.font = font
        self.textColor = color
    }
}
