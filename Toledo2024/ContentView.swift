//
//  ContentView.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/15/24.
//

import SwiftUI

struct ContentView: View {
        
    @State private var selection: TaskSection? = TaskSection.initialValue
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationSplitView {
            SidebarView(selection: $selection)
        } detail: {
            TaskList(title: "xAll", selection: selection, searchTerm: searchTerm)
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
