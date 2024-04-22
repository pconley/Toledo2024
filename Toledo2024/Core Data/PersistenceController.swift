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
    
    func save() {
        let context = container.viewContext
        
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            print("saved!")
        } catch {
            print("error saving context: \(error)")
        }
    }
    
    //MARK: - SwiftUI preview helper
    
    static var preview: PersistenceController = {
       let controller = PersistenceController(inMemory: true)
       let context = controller.container.viewContext
        
        for index in 0..<5 {
            let task = CDTask(title: "some new task \(index)", dueDate: Date(), context: context)
        }
        
        let doneTask = CDTask(title: "A done task", dueDate: Date(), context: context)
        doneTask.isCompleted.toggle()
        
        
        let multiStepTask = CDTask(title: "Take 3 steps", dueDate: Date(), context: context)
        let sub1 = CDTask(title: "Subtask 1", dueDate: Date(), context: context)
        let sub2 = CDTask(title: "Subtask 2", dueDate: Date(), context: context)
        let sub3 = CDTask(title: "Subtask 3", dueDate: Date(), context: context)
        multiStepTask.subTasks.formUnion([sub1, sub2, sub3])
        
        return controller
    }()
    
}
