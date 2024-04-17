//
//  ContentView.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/15/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userCreatedGroups: [TaskGroup] = TaskGroup.examples()
    @State private var allTasks = Task.examples()
    @State private var selection: TaskSection? = TaskSection.all // nil for phone (stacked)
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationSplitView {
            SidebarView(userCreatedGroups: $userCreatedGroups, selection: $selection)
//                .searchable(text: $searchText, placement: .sidebar)
                .searchable(text: $searchTerm)
        } detail: {
            if searchTerm.isEmpty {
                switch selection {
                case .all:
                    TaskListView(title: "All", tasks: $allTasks)
                case .done:
                    StaticTaskListView(title: "Done", tasks: allTasks.filter({$0.isCompleted}))
                case .upcoming:
                    StaticTaskListView(title: "Open", tasks: allTasks.filter({!$0.isCompleted}))
                case .list(let TaskGroup):
                    StaticTaskListView(title: TaskGroup.title, tasks: TaskGroup.tasks)
                case .none:
                    Text("none")
                }
            } else {
                StaticTaskListView(title: "All", tasks: allTasks.filter({$0.title.contains(searchTerm)}))

            }
        }
    }
}

#Preview {
    ContentView()
}
