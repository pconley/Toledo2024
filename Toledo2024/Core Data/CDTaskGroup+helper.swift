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
        get { title_ ?? "" }
        set { title_ = newValue }
    }
    
    var createdAt: Date {
        createdAt_ ?? Date()
    }
    
    convenience init(title: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
    }
    
    public override func awakeFromInsert() {
        self.uuid_ = UUID()
        self.createdAt_ = Date()
    }
}
