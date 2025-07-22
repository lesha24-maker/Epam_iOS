//
//  ViewController.swift
//  ApplicationBundle2
//
//  Created by Alexey Lim on 18/7/25.
//

import UIKit

class ViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var photos: [Photo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        fetchPhotoList()
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Image Gallery"
        let clearCacheButton = UIBarButtonItem(title: "Clear Cache", style: .plain, target: self, action: #selector(clearCacheButtonTapped))
        navigationItem.rightBarButtonItem = clearCacheButton
    }

    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let itemSize = (view.bounds.width - 6) / 3
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        view.addSubview(collectionView)
    }

    private func fetchPhotoList() {
        NetworkManager.shared.fetchPhotos { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let photos):
                self.photos = photos
                self.collectionView.reloadData()
            case .failure(let error):
                print("Failed to fetch photos: \(error.localizedDescription)")
            }
        }
    }

    @objc private func clearCacheButtonTapped() {
        ImageCacheManager.shared.manualClearCache()
        
        let alert = UIAlertController(title: "Cache Cleared", message: "The image cache has been deleted. Please restart the app to see the effect.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as! PhotoCell
        
        let photo = photos[indexPath.item]
        
        if let url = URL(string: photo.urls.small) {
            cell.configure(with: url)
        }
        
        return cell
    }
}
