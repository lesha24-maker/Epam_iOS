//
//  ThemeManager.swift
//  UserDefaults1
//
//  Created by Alexey Lim on 23/7/25.
//

import UIKit

final class ThemeManager {
    
    static let shared = ThemeManager()
    
    private let themeKey = "themePreference"
    
    enum Theme: Int {
        case light, dark, system
    }
    
    private init() {
        applyTheme()
    }
    
    func applyTheme() {
        let savedThemeValue = UserDefaults.standard.integer(forKey: themeKey)
        let theme = Theme(rawValue: savedThemeValue) ?? .system
        
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .forEach { windowScene in
                windowScene.windows.forEach { window in
                    switch theme {
                    case .light:
                        window.overrideUserInterfaceStyle = .light
                    case .dark:
                        window.overrideUserInterfaceStyle = .dark
                    case .system:
                        window.overrideUserInterfaceStyle = .unspecified
                    }
                }
            }
    }
    
    func setTheme(_ theme: Theme) {
        UserDefaults.standard.set(theme.rawValue, forKey: themeKey)
        applyTheme()
    }
    
    func getCurrentTheme() -> Theme {
        let savedThemeValue = UserDefaults.standard.integer(forKey: themeKey)
        return Theme(rawValue: savedThemeValue) ?? .system
    }
}
