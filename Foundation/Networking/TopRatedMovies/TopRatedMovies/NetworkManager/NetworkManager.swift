//
//  NetworkManager.swift
//  TopRatedMovies
//
//  Created by Alexey Lim on 9/7/25.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case requestFailed(Error)
    case invalidResponse
    case badStatusCode(Int)
    case decodingError(Error)
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let apiKey = "7481bbcf1fcb56bd957cfe9af78205f3"
    private let baseURL = "https://api.themoviedb.org/3/tv"
    
    func fetchTopRatedSeries(completion: @escaping (Result<[TVSeries], NetworkError>) -> Void) {
        
        guard var urlComponents = URLComponents(string: "\(baseURL)/top_rated") else {
            completion(.failure(.badURL))
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.requestFailed(error)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.badStatusCode(httpResponse.statusCode)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(apiResponse.results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }.resume()
    }
}
