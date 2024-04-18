//
//  CDTask+helper.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/17/24.
//

import Foundation
import CoreData

extension CDTask {
    
    var uuid: UUID {
        #if DEBUG
        uuid_!
        #else
        uuid_ ?? UUID()
        #endif
    }
    
    var title: String {
        get { title_ ?? "xxx" }
        set { title_ = newValue }
    }
    
    var dueDate: Date {
        get { dueDate_ ?? Date() }
        set { dueDate_ = newValue }
    }
    
    convenience init(title: String, dueDate: Date, context: NSManagedObjectContext) {
//        let logger = Logger()
//        let x = 42
//        logger.info("The answer is \(x)")
        self.init(context: context)
        self.title = "pat"
        self.title_ = "joe"
        self.dueDate = dueDate
    }
    
    public override func awakeFromInsert() {
        self.uuid_ = UUID()
    }
    
    //MARK: - Preview helpers
    
    static var example: CDTask {
        let context = PersistenceController.preview.container.viewContext
        let task = CDTask(title: "Buy dog some food", dueDate: Date(), context: context)
        
        return task
    }
}
