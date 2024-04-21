//
//  ContentView.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/15/24.
//

import SwiftUI

struct ContentView: View {
    
    let persistentController = PersistenceController.shared
    
    @State private var userCreatedGroups: [TaskGroup] = TaskGroup.examples()
    @State private var allTasks = Task.examples()
    @State private var selection: TaskSection? = TaskSection.initialValue
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationSplitView {
            SidebarView(selection: $selection)
        } detail: {
            if searchTerm.isEmpty {
                switch selection {
                case .all, .done, .upcoming:
                    // FIXME: "all" shows as the title for all 3 selectins
                    TaskListView(title: "All", selection: selection)
                case .list(let TaskGroup):
                      Text("placeholder for list")
                case .none:
                    Text("none")
                }
            } else {
                StaticTaskListView(title: "All", tasks: allTasks.filter({$0.title.contains(searchTerm)}))

            }
        }
        .searchable(text: $searchTerm)
    }
}

#Preview {
    ContentView()
        .environment(
            \.managedObjectContext,
            PersistenceController.preview.container.viewContext
        )
}
