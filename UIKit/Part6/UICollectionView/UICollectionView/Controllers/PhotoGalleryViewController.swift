//
//  ViewController.swift
//  UICollectionView
//
//  Created by Alexey Lim on 1/7/25.
//
// PhotoGalleryViewController.swift

import UIKit

class PhotoGalleryViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Gallery"
        view.backgroundColor = .systemBackground
        
        loadData()
        setupCollectionView()
        setupLongPressGesture()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
    
    private func loadData() {
        let allPhotos = [
            Photo(imageName: "image1", title: "Forest Sunrise", date: date(year: 2023, month: 11, day: 20), isFavorite: false),
            Photo(imageName: "image2", title: "Mountain Peak", date: date(year: 2023, month: 8, day: 5), isFavorite: true),
            Photo(imageName: "image3", title: "Coastal Cliffs", date: date(year: 2023, month: 5, day: 12), isFavorite: false),
            Photo(imageName: "image4", title: "City at Night", date: date(year: 2022, month: 12, day: 1), isFavorite: false),
            Photo(imageName: "image5", title: "Desert Dunes", date: date(year: 2022, month: 9, day: 30), isFavorite: true),
            Photo(imageName: "image6", title: "Icy River", date: date(year: 2022, month: 2, day: 18), isFavorite: false),
            Photo(imageName: "image7", title: "Autumn Path", date: date(year: 2021, month: 10, day: 25), isFavorite: false),
            Photo(imageName: "image8", title: "Tropical Beach", date: date(year: 2021, month: 7, day: 15), isFavorite: false),
            Photo(imageName: "image9", title: "Old Bridge", date: date(year: 2021, month: 4, day: 9), isFavorite: true)
        ]
        
        let groupedByYear = Dictionary(grouping: allPhotos) { photo in
            Calendar.current.component(.year, from: photo.date)
        }
        
        self.sections = groupedByYear.map { (year, photos) in
            Section(year: year, photos: photos.sorted(by: { $0.date > $1.date }))
        }.sorted(by: { $0.year > $1.year })
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state != .began {
            return
        }
        
        let point = gesture.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: point) {
            let photo = sections[indexPath.section].photos[indexPath.row]
            
            let alert = UIAlertController(title: "Delete Photo", message: "Are you sure you want to delete '\(photo.title)'?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
                self?.deleteItem(at: indexPath)
            }))
            
            present(alert, animated: true)
        }
    }
    
    private func deleteItem(at indexPath: IndexPath) {
        sections[indexPath.section].photos.remove(at: indexPath.row)
        
        collectionView.performBatchUpdates({
            if sections[indexPath.section].photos.isEmpty {
                sections.remove(at: indexPath.section)
                collectionView.deleteSections(IndexSet(integer: indexPath.section))
            } else {
                collectionView.deleteItems(at: [indexPath])
            }
        }, completion: nil)
    }
    
    private func toggleFavorite(at indexPath: IndexPath) {
        sections[indexPath.section].photos[indexPath.row].isFavorite.toggle()
        
        let photo = sections[indexPath.section].photos[indexPath.row]
        let message = photo.isFavorite ? "Marked \(photo.title) as Favorite!" : "Removed \(photo.title) from Favorites."
        
        showAlert(message: message)
        
        collectionView.reloadItems(at: [indexPath])
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            alert.dismiss(animated: true)
        }
    }
    
    private func date(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return Calendar.current.date(from: components) ?? Date()
    }
    
    struct Section {
        let year: Int
        var photos: [Photo]
    }
}

extension PhotoGalleryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            fatalError("Failed to dequeue PhotoCell.")
        }
        
        let photo = sections[indexPath.section].photos[indexPath.row]
        cell.configure(with: photo)
        
        cell.favoriteButtonTapped = { [weak self] in
            self?.toggleFavorite(at: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath) as? HeaderView else {
            return UICollectionReusableView()
        }
        
        let year = sections[indexPath.section].year
        header.configure(with: String(year))
        return header
    }
}

extension PhotoGalleryViewController: UICollectionViewDelegateFlowLayout {
    
    private var isLandscape: Bool {
        view.bounds.width > view.bounds.height
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let itemSpacing: CGFloat = 10
        let columns: CGFloat = isLandscape ? 5 : 3
        
        let totalHorizontalPadding = (padding * 2) + (itemSpacing * (columns - 1))
        let availableWidth = collectionView.bounds.width - totalHorizontalPadding
        let itemWidth = availableWidth / columns
        
        let itemHeight = itemWidth * 1.3
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 16, bottom: 20, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
}
