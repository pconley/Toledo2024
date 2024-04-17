//
//  StaticTaskListView.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/17/24.
//

import Foundation

import SwiftUI

struct StaticTaskListView: View {
    
    let title: String
    let tasks: [Task]
    
    var body: some View {
        List(tasks) { task in
            HStack {
                Image(systemName: task.isCompleted ? "largecircle.fill.circle" : "circle")
                Text(task.title) }
        }
    }
}

#Preview {
    StaticTaskListView(title: "All", tasks: Task.examples() )
}
