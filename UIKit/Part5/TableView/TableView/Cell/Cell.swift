//
//  Cell.swift
//  TableView
//
//  Created by Alexey Lim on 26/6/25.
//

import UIKit

class GymClassTableViewCell: UITableViewCell {

    static let identifier = "GymClassTableViewCell"
    var registrationButtonAction: (() -> Void)?

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .systemPink
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var classNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var trainerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12.5
        imageView.tintColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var trainerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(timeLabel)
        contentView.addSubview(durationLabel)
        contentView.addSubview(classNameLabel)
        contentView.addSubview(trainerImageView)
        contentView.addSubview(trainerNameLabel)
        contentView.addSubview(registrationButton)

        setupConstraints()
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func registrationButtonTapped() {
        registrationButtonAction?()
    }

    private func setupConstraints() {
        let timeStackView = UIStackView(arrangedSubviews: [timeLabel, durationLabel])
        timeStackView.axis = .vertical
        timeStackView.spacing = 2
        timeStackView.alignment = .leading
        timeStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timeStackView)

        let trainerInfoStackView = UIStackView(arrangedSubviews: [trainerImageView, trainerNameLabel])
        trainerInfoStackView.axis = .horizontal
        trainerInfoStackView.spacing = 6
        trainerInfoStackView.alignment = .center
        
        let classDetailsStackView = UIStackView(arrangedSubviews: [classNameLabel, trainerInfoStackView])
        classDetailsStackView.axis = .vertical
        classDetailsStackView.spacing = 6
        classDetailsStackView.alignment = .leading
        classDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(classDetailsStackView)

        NSLayoutConstraint.activate([
            timeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            timeStackView.widthAnchor.constraint(equalToConstant: 60),

            registrationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            registrationButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            registrationButton.widthAnchor.constraint(equalToConstant: 40),
            registrationButton.heightAnchor.constraint(equalToConstant: 40),

            classDetailsStackView.leadingAnchor.constraint(equalTo: timeStackView.trailingAnchor, constant: 12),
            classDetailsStackView.trailingAnchor.constraint(equalTo: registrationButton.leadingAnchor, constant: -12),
            classDetailsStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            classDetailsStackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10),
            classDetailsStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),

            trainerImageView.widthAnchor.constraint(equalToConstant: 25),
            trainerImageView.heightAnchor.constraint(equalToConstant: 25),
        ])
    }

    func configure(with classData: [String: Any]) {
        timeLabel.text = classData["time"] as? String
        durationLabel.text = classData["duration"] as? String
        classNameLabel.text = classData["className"] as? String
        trainerNameLabel.text = classData["trainerName"] as? String
        
        if let photoName = classData["trainerPhoto"] as? String {
            if let image = UIImage(named: photoName) {
                trainerImageView.image = image
            } else {
                trainerImageView.image = UIImage(systemName: photoName) ?? UIImage(systemName: "person.circle")
            }
        } else {
            trainerImageView.image = UIImage(systemName: "person.circle")
        }

        let isRegistered = classData["isRegistered"] as? Bool ?? false
        updateRegistrationButton(isRegistered: isRegistered)
        
        if isRegistered {
            self.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        } else {
            self.backgroundColor = .systemBackground
        }
    }

    private func updateRegistrationButton(isRegistered: Bool) {
        if isRegistered {
            registrationButton.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)), for: .normal)
            registrationButton.backgroundColor = .systemPink
            registrationButton.tintColor = .white
            registrationButton.layer.borderWidth = 0
        } else {
            registrationButton.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)), for: .normal)
            registrationButton.backgroundColor = .systemBackground
            registrationButton.tintColor = .label
            registrationButton.layer.borderColor = UIColor.gray.cgColor
            registrationButton.layer.borderWidth = 1
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timeLabel.text = nil
        durationLabel.text = nil
        classNameLabel.text = nil
        trainerImageView.image = nil
        trainerNameLabel.text = nil
        registrationButtonAction = nil
        self.backgroundColor = .systemBackground
    }
}
