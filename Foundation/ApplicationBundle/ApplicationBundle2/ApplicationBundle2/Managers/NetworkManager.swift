//
//  NetworkManager.swift
//  ApplicationBundle2
//
//  Created by Alexey Lim on 22/7/25.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.unsplash.com/"
    
    private let accessKey = "NWPfVC7aHkhvLB3-XRzlms5PM-TcSrB1_gaVHI0Negg"

    private init() {}
    
    func fetchPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)photos/random?count=30&client_id=\(accessKey)") else {
            completion(.failure(NSError(domain: "NetworkManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NetworkManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(photos))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
