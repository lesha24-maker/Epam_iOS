//
//  AddTaskView.swift
//  EnvironmentObjects2
//
//  Created by Alexey Lim on 22/8/25.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var taskManager: TaskManager
    
    @State private var newTaskName: String = ""

    var body: some View {
        HStack {
            TextField("Enter a new task...", text: $newTaskName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Add") {
                taskManager.addTask(name: newTaskName)
                newTaskName = ""
            }
            .buttonStyle(.borderedProminent)
            .disabled(newTaskName.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .padding()
    }
}
