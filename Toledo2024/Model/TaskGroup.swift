//
//  TaskGroup.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/15/24.
//

import Foundation

struct TaskGroup: Identifiable, Hashable {
    let id = UUID()
    var title: String
    let createdAt: Date
    var tasks: [Task]
    
    init(title: String, tasks: [Task] = []) {
        self.title = title
        self.createdAt = Date()
        self.tasks = tasks
    }
    
    static func  example() -> TaskGroup {
        let task1 = Task(title: "Buy apples")
        let task2 = Task(title: "finish my app")
        let task3 = Task(title: "buy options")
        
        var group = TaskGroup(title: "Personal")
        group.tasks = [task1, task2, task3]
        return group
    }
    
    static func  examples() -> [TaskGroup] {
        let group1 = TaskGroup.example()
        let group2 = TaskGroup(title: "New List")
        return [group1, group2]
    }
    
}
