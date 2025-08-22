//
//  ContentView.swift
//  EnvironmentObjects2
//
//  Created by Alexey Lim on 22/8/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var taskManager = TaskManager()

    var body: some View {
        NavigationStack {
            VStack {
                AddTaskView()
                TaskListView()
            }
            .navigationTitle("Task List")
            .environmentObject(taskManager)
        }
    }
}

#Preview {
    ContentView()
}
