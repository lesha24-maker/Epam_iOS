//
//  ListItem.swift
//  SwiftUILayout6
//
//  Created by Alexey Lim on 16/8/25.
//

import Foundation

struct ListItem: Identifiable {
    var id: String { name }
    var name: String
    var isToggled: Bool
}
