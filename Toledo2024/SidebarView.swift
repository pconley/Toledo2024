//
//  SidebarView.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/15/24.
//

import SwiftUI

struct SidebarView: View {
    
    @Binding var userCreatedGroups: [TaskGroup]
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
                ForEach($userCreatedGroups){ $group in
                    HStack {
                        Image(systemName: "folder")
                        TextField("New Group", text: $group.title)
                    }
                    .tag(TaskSection.list(group))
                    .contextMenu {
                        Button("Delete", role: .destructive){
//                            if let index = userCreatedGroups.firstIndex(where: {$0.id == group.id}) {
//                                userCreatedGroups.remove(at: index)
//                            }
                            let ndx = userCreatedGroups.firstIndex(where: {$0.id == group.id})
                            if ndx != nil {
                                userCreatedGroups.remove(at: ndx!) //unwrapped????
                            }
                        }
                    }
                }
            }
        }.safeAreaInset(edge: .bottom) {
            Button (action: {
                let newGroup = TaskGroup(title: "New Group")
                userCreatedGroups.append(newGroup)
            }, label: {
                Label("Add Button", systemImage: "plus.circle")
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
        userCreatedGroups: .constant(TaskGroup.examples()),
        selection: .constant(.all)
    ).listStyle(.sidebar)
}

