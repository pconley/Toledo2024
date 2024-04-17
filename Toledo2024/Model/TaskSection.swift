//
//  TaskSection.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/15/24.
//

import Foundation

enum TaskSection: Identifiable, CaseIterable, Hashable {

    case all
    case done
    case upcoming
    case list(TaskGroup)
    
    var id: String {
        switch self {
        case .all: "all"
        case .done: "done"
        case .upcoming: "upcoming"
        case .list(let taskGroup):
            taskGroup.id.uuidString
        }
    }
    
    var displayName: String {
        switch self {
        case .all: "All"
        case .done: "Completed"
        case .upcoming: "Upcoming"
        case .list(let taskGroup):
            taskGroup.title
        }
    }
        
    var iconName: String {
        switch self {
        case .all: "star"
        case .done: "checkmark.circle"
        case .upcoming: "calendar"
//        case .list(let taskGroup): "folder"
        case .list(_): "folder"
        }
    }
    
    static var allCases: [TaskSection] {
        return [.all, .done, .upcoming]
    }
    
    static func == (lhs: TaskSection, rhs: TaskSection) -> Bool {
        lhs.id == rhs.id
    }
}
