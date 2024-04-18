//
//  TaskRow.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/17/24.
//

import SwiftUI

struct TaskRow: View {
    @ObservedObject var task: CDTask
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "largecircle.fill.circle" : "circle")
                .onTapGesture { task.isCompleted.toggle()
            }
            TextField("New Task", text: $task.title)
                .textFieldStyle(.plain)
        }
    }
}

#Preview {
//    Text(CDTask.example.title)
    TaskRow(task: CDTask.example)
}
