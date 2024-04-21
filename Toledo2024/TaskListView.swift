//
//  TaskListView.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/15/24.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    
    let title: String
    
    @FetchRequest(fetchRequest: CDTask.fetch()) var tasks
    
    @State private var selectedTask: CDTask? = nil
    
    @State private var inspectorIsShown: Bool = false
    
    @Environment(\.managedObjectContext) var context
    
    init(title: String, selection: TaskSection?) {
        self.title = title
        
        let request = CDTask.fetch()
        switch selection {
            case .all:
                request.predicate = nil
            case .done:
                request.predicate = NSPredicate(format: "isCompleted == true")
            case .upcoming:
                request.predicate = NSPredicate(format: "isCompleted == false")
            case .list(let group):
                request.predicate = nil
//                request.predicate = NSPredicate(format: "group == %@", group as CVarArg)
            case nil:
                request.predicate = NSPredicate.none
        }

        self._tasks = FetchRequest(fetchRequest: request, animation: .bouncy)
    }
    
    var body: some View {
        List(tasks) { task in
            TaskRow(task: task)
        }
        .navigationTitle(title)
        .toolbar {
            Button {
                _ = CDTask(title: "NewT", dueDate: Date(), context: context)
            } label: {
                Label("Add new task", systemImage: "plus")
            }
        }
    }
}

#Preview {
    TaskListView(title: "All", selection: .all )
        .environment(
            \.managedObjectContext,
            PersistenceController.preview.container.viewContext
        )
}
