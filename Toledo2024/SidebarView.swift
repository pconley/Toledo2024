//
//  SidebarView.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/15/24.
//

import SwiftUI

struct SidebarView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(fetchRequest: CDTaskGroup.fetch(), animation: .bouncy) var taskGroups: FetchedResults<CDTaskGroup>
    
    @Binding var selection: TaskSection?
    
    var body: some View {
        List (selection: $selection) {
            Section("Favorites"){
                ForEach(TaskSection.allCases){ section in
                    Label(section.displayName, systemImage: section.iconName)
                        .tag(section)
                }
            }
        
            Section ("Your Groups"){
                ForEach(taskGroups){ group in
                    TaskGroupRow(taskGroup: group)
                    .tag(TaskSection.list(group))
                    .contextMenu {
                        Button("Delete", role: .destructive){
                            CDTaskGroup.delete(taskGroup: group)
                            }
                    }
                }
            }
        }.safeAreaInset(edge: .bottom) {
            Button (action: {
                _ = CDTaskGroup(title: "New", context: context)
            }, label: {
                Label("Add Group", systemImage: "plus.circle")
            })
            .buttonStyle(.borderless)
            .foregroundColor(.accentColor)
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .keyboardShortcut(/*@START_MENU_TOKEN@*/KeyEquivalent("a")/*@END_MENU_TOKEN@*/, modifiers: /*@START_MENU_TOKEN@*/.command/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    SidebarView(
        selection: .constant(.all)
    )
    .listStyle(.sidebar)
    .environment(
        \.managedObjectContext,
        PersistenceController.preview.container.viewContext
    )
}

