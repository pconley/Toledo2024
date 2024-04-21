//
//  Toledo2024App.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/15/24.
//

import SwiftUI

@main
struct Toledo2024App: App {
    
    let persistentController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistentController.container.viewContext)
        }
        .commands {
            CommandMenu("Tasks") {
                Button("Add new task") {
                    
                }
                .keyboardShortcut(KeyEquivalent("r"), modifiers: .command)
            }
            
            CommandGroup(after: .newItem) {
                Button("Add new group") {
                    
                }
            }
        }
        
        #if os(macOS)
        
        Settings {
            Text("Settings").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        }
        
        MenuBarExtra("Todo") {
            Button("To do something"){
                
            }
        }
        
        #endif
    }
}
