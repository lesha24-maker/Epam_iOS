//
//  ViewController.swift
//  ScrollView
//
//  Created by Alexey Lim on 18/6/25.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let contentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "large-image")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        scrollView.delegate = self
        
        setupViews()
        setupConstraints()
        setupZoomScales()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentContainerView)
        contentContainerView.addSubview(imageView)
    }
    
    private func setupConstraints() {
        guard let image = imageView.image else { return }

        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide
        let padding: CGFloat = 20.0

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentContainerView.topAnchor.constraint(equalTo: contentGuide.topAnchor),
            contentContainerView.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor),
            contentContainerView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            contentContainerView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            contentContainerView.widthAnchor.constraint(equalTo: frameGuide.widthAnchor),
            
            imageView.widthAnchor.constraint(equalTo: contentContainerView.widthAnchor, constant: -(padding * 2)),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: image.size.height / image.size.width),
            
            imageView.centerXAnchor.constraint(equalTo: contentContainerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentContainerView.centerYAnchor),

            contentContainerView.heightAnchor.constraint(greaterThanOrEqualTo: frameGuide.heightAnchor),
            contentContainerView.heightAnchor.constraint(greaterThanOrEqualTo: imageView.heightAnchor, constant: padding * 2)
        ])
    }
    
    private func setupZoomScales() {
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentContainerView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print("ScrollView did zoom to scale: \(scrollView.zoomScale)")
    }
}
