//
//  Structs.swift
//  ApplicationBundle2
//
//  Created by Alexey Lim on 22/7/25.
//

import Foundation

struct Photo: Codable, Hashable {
    let id: String
    let urls: PhotoURLs
}

struct PhotoURLs: Codable, Hashable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
