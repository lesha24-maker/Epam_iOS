//
//  AppConfig.swift
//  ApplicationBundle3
//
//  Created by Alexey Lim on 18/7/25.
//

import Foundation

struct AppConfig: Codable {
    let screenTitle: String
    let displayImageBorder: Bool
    let borderColorHex: String
    let imagesToShow: [ImageConfig]
}

struct ImageConfig: Codable {
    let name: String
    let caption: String
}
