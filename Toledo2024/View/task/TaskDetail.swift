//
//  TaskDetailView.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/21/24.
//

import SwiftUI

struct TaskDetail: View {
    
    @Environment(\.managedObjectContext) var context
    @ObservedObject var task: CDTask
    
    var body: some View {
        List {
            Text(task.title).font(.title3).bold()
            
            Toggle(task.isCompleted ? "Completed" : "Open", isOn: $task.isCompleted)
            
            DatePicker("Due Date", selection: $task.dueDate)
            
            Divider()
            
            Section("Sub Tasks") {
                ForEach(task.subTasks.sorted()) { subtask in
                    TaskRow(task: subtask,
                            selectedTask: .constant(nil),
                            inspectorIsShown: .constant(false),
                            showMoreButton: false
                    )
                    .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 10))
                }
                
                Button(action: {
                    let subTask = CDTask(title: "subtask", dueDate: Date(), context: context)
                    subTask.parentTask = task
                    
                }, label: {
                    Label("New Sub Task", systemImage: "plus.circle")
                })
                .buttonStyle(.borderless)
                .foregroundColor(.green)
                .listRowInsets(.init(top: 15, leading: 0, bottom: 5, trailing: 10))
            }
        }
        .listStyle(.sidebar)
    }
}

#Preview {
    TaskDetail(task: CDTask.example)
}
