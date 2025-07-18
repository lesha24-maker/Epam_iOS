//
//  ImageCacheManager.swift
//  ApplicationBundle2
//
//  Created by Alexey Lim on 18/7/25.
//

import UIKit

final class ImageCacheManager {

    static let shared = ImageCacheManager()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL

    private init() {
        self.cacheDirectory = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("ImageCache")
        try? fileManager.createDirectory(at: self.cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(clearCacheOnMemoryWarning),
            name: UIApplication.didReceiveMemoryWarningNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func getImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let cacheKey = url.lastPathComponent
        let fileURL = cacheDirectory.appendingPathComponent(cacheKey)

        if let cachedData = try? Data(contentsOf: fileURL), let image = UIImage(data: cachedData) {
            DispatchQueue.main.async {
                completion(.success(image))
            }
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data, let image = UIImage(data: data) else {
                    let customError = NSError(domain: "ImageCacheManagerError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid image data."])
                    completion(.failure(customError))
                    return
                }
                
                try? data.write(to: fileURL)
                completion(.success(image))
            }
        }.resume()
    }

    public func manualClearCache() {
        clearCache()
    }

    @objc private func clearCacheOnMemoryWarning() {
        clearCache()
    }
    
    private func clearCache() {
        guard let files = try? fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil, options: []) else { return }
        for file in files {
            try? fileManager.removeItem(at: file)
        }
    }
}
