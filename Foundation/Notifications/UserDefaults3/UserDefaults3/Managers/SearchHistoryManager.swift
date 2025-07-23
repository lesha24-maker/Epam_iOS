//
//  SearchHistoryManager.swift
//  UserDefaults3
//
//  Created by Alexey Lim on 23/7/25.
//

import Foundation

final class SearchHistoryManager {
    
    static let shared = SearchHistoryManager()
    
    private let historyKey = "userSearchHistory"
    
    private let maxHistoryCount = 5

    private init() {}

    func getSearchHistory() -> [String] {
        return UserDefaults.standard.array(forKey: historyKey) as? [String] ?? []
    }

    func saveSearchTerm(_ term: String) {
        var history = getSearchHistory()

        history.removeAll { $0.lowercased() == term.lowercased() }

        history.insert(term, at: 0)

        if history.count > maxHistoryCount {
            history.removeLast()
        }
        
        UserDefaults.standard.set(history, forKey: historyKey)
        print("Updated search history: \(history)")
    }
}
