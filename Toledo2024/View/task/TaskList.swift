//
//  TaskList.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/21/24.
//

import SwiftUI
import CoreData

struct TaskList: View {
    
    let title: String
    
    @FetchRequest(fetchRequest: CDTask.fetch(), animation: .bouncy) var tasks
    
    @State private var selectedTask: CDTask? = nil
    @State private var inspectorIsShown: Bool = false
    
    @Environment(\.managedObjectContext) var context
    
    let group: CDTaskGroup?
    
    init(title: String, selection: TaskSection?, searchTerm: String) {
        self.title = title
        
        let request = CDTask.fetch()
        
        if searchTerm.isEmpty {
            switch selection {
            case .all:
                request.predicate = nil
            case .done:
                request.predicate = NSPredicate(format: "isCompleted == true")
            case .upcoming:
                request.predicate = NSPredicate(format: "isCompleted == false")
            case .list(let group):
                request.predicate = NSPredicate(format: "group == %@", group as CVarArg)
            case nil:
                request.predicate = NSPredicate.none
            }
        } else {
            // [cd] means a case insensitive search. title_ could have been directly in the string
            // the %K seems to have a meaning not just a placeholder (i tried %F)
            request.predicate = NSPredicate(format: "%K CONTAINS[cd] %@", "title_", searchTerm as CVarArg)
        }
                
        switch selection {
            case .list(let group):
                self.group = group
            case .all, .done, .upcoming, nil:
                group = nil
        }

        self._tasks = FetchRequest(fetchRequest: request, animation: .bouncy)
    }
    
    var body: some View {
        List(tasks) { task in
            TaskRow(task: task,
                    selectedTask: $selectedTask,
                    inspectorIsShown: $inspectorIsShown)
            .foregroundColor(selectedTask == task ? .accent : .gray)
        }
        .navigationTitle(title)
        .toolbar {
            Button {
                inspectorIsShown.toggle()
            } label: {
                Label("Toggle inspector", systemImage: "sidebar.right")
            }
            
            Button {
                let task = CDTask(title: "NewT", dueDate: Date(), context: context)
                task.group = group
            } label: {
                Label("Add new task", systemImage: "plus")
            }
        }
        .inspector(isPresented: $inspectorIsShown){
            if let selectedTask {
                TaskDetail(task: selectedTask)
            } else {
                ContentUnavailableView("Please select a task", systemImage: "circle.inset.filled")
            }
        }
    }
}

#Preview {
//    TaskListView(title: "Test", selection: .list(CDTaskGroup.example))

    TaskList(title: "Testy", selection: .all, searchTerm: "" )
        .environment(
            \.managedObjectContext,
            PersistenceController.preview.container.viewContext
        )
}

