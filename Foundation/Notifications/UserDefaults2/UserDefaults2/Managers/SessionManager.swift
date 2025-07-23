//
//  SessionManager.swift
//  UserDefaults2
//
//  Created by Alexey Lim on 23/7/25.
//

import Foundation

final class SessionManager {
    
    static let shared = SessionManager()
    
    private enum UserDefaultKeys {
        static let isLoggedIn = "isLoggedIn"
        static let userEmail = "userEmail"
    }
    
    var isLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultKeys.isLoggedIn)
    }
    
    private init() {}
    
    func login(with email: String) {
        UserDefaults.standard.set(true, forKey: UserDefaultKeys.isLoggedIn)
        UserDefaults.standard.set(email, forKey: UserDefaultKeys.userEmail)
        print("User logged in with email: \(email)")
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKeys.isLoggedIn)
        UserDefaults.standard.removeObject(forKey: UserDefaultKeys.userEmail)
        print("User logged out and session data cleared.")
    }
    
    func getUserEmail() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultKeys.userEmail)
    }
}
