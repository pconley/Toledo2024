//
//  CDTaskGroup+helper.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/17/24.
//

import Foundation
import CoreData

extension CDTaskGroup {
 
    var uuid: UUID {
        #if DEBUG
        uuid_!
        #else
        uuid_ ?? UUID()
        #endif
    }
    
    var title: String {
        get { title_ ?? ""  }
        set { title_ = newValue }
    }
    
    var createdAt: Date {
        createdAt_ ?? Date()
    }
    
    var tasks: Set<CDTask> {
        get { (tasks_ as? Set<CDTask>) ?? [] }
        set { tasks_ = newValue as NSSet }
    }
    
    convenience init(title: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
    }
    
    public override func awakeFromInsert() {
        self.uuid_ = UUID()
        self.createdAt_ = Date()
    }
    
    static func delete(taskGroup: CDTaskGroup) {
        guard let context = taskGroup.managedObjectContext else { return }
        
        context.delete(taskGroup)
    }
    
    static func fetch(_ predicate: NSPredicate = .all) -> NSFetchRequest<CDTaskGroup> {
        let request = CDTaskGroup.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDTaskGroup.title_, ascending: true),
                                   NSSortDescriptor(keyPath: \CDTaskGroup.createdAt_, ascending: true)]
        request.predicate = predicate
        
        return request
    }
    
    
    //MARK: - Preview helpers
    
    static var example: CDTaskGroup {
        let context = PersistenceController.preview.container.viewContext
        let taskGroup = CDTaskGroup(title: "Groceries", context: context)
        
        taskGroup.tasks.insert(CDTask.example)
        
        return taskGroup
    }
    
    
}
