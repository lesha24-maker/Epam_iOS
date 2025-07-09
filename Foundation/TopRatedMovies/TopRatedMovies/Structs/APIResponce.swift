//
//  APIResponce.swift
//  TopRatedMovies
//
//  Created by Alexey Lim on 9/7/25.
//

import Foundation

struct APIResponse: Codable {
    let results: [TVSeries]
}

struct TVSeries: Codable {
    let id: Int
    let name: String
    let overview: String
    let posterPath: String?
    let firstAirDate: String
    let voteAverage: Double
    let popularity: Double
    let originCountry: [String]

    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case popularity
        case originCountry = "origin_country"
    }
}
