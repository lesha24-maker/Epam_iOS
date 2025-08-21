//
//  SettingsItem.swift
//  StateManagement6
//
//  Created by Alexey Lim on 21/8/25.
//

import Foundation

struct SettingItem: Identifiable {
    let id = UUID()
    
    var name: String
    var isOn: Bool
}
