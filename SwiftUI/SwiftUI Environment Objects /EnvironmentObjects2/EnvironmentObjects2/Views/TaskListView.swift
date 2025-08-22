//
//  TaskListView.swift
//  EnvironmentObjects2
//
//  Created by Alexey Lim on 22/8/25.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var taskManager: TaskManager
    
    var body: some View {
        List {
            ForEach(taskManager.tasks, id: \.self) { task in
                Text(task)
            }
            .onDelete(perform: taskManager.removeTask)
        }
    }
}
