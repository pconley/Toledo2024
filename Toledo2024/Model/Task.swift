//
//  Task.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/15/24.
//

import Foundation

struct Task: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
    var dueDate: Date
    var details: String?
    
    init(title: String, isCompleted: Bool = false, dueDate: Date = Date(), details: String? = nil) {
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
        self.details = details
    }
    
    static func example() -> Task {
        Task(title: "Buy milk", dueDate: Calendar.current.date(byAdding:.day, value:2, to:Date())!)
    }
    
    static func examples() -> [Task] {
        [
            Task(title: "here is a first exampke"),
            Task(title: "create a desktop app", isCompleted: true),
            Task(title: "add data storage", dueDate: Calendar.current.date(byAdding: .month, value: 1, to: Date())!)
        ]
    }
}
