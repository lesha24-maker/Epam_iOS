//
//  TaskManager.swift
//  EnvironmentObjects2
//
//  Created by Alexey Lim on 22/8/25.
//

import SwiftUI

class TaskManager: ObservableObject {
    
    @Published var tasks: [String] = ["Buy milk", "Walk the dog", "Learn SwiftUI"]
    
    func addTask(name: String) {
        
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        if !trimmedName.isEmpty {
            tasks.append(trimmedName)
        }
    }
    
    func removeTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
