//
//  PersistenceController.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/17/24.
//

import Foundation
import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        self.container = NSPersistentContainer(name: "Toledo2024")
        
        if inMemory {
            // tell core data to not actually store data in a file
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Error loading container: \(error), \(error.userInfo)")
            }
        }
    }
    
    //MARK: - SwiftUI preview helper
    
    static var preview: PersistenceController = {
       let controller = PersistenceController(inMemory: true)
       let context = controller.container.viewContext
        
        for index in 0..<10 {
            let task = CDTask(title: "some new task \(index)", dueDate: Date(), context: context)
        }
        
        let doneTask = CDTask(title: "A done task", dueDate: Date(), context: context)
        doneTask.isCompleted.toggle()
        
        return controller
    }()
    
}
