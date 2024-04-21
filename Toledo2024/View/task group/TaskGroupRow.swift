//
//  TaskGroupRow.swift
//  Toledo2024
//
//  Created by Patrick Conley on 4/19/24.
//

import SwiftUI

struct TaskGroupRow: View {
    
    @ObservedObject var taskGroup: CDTaskGroup
    
    var body: some View {
        HStack {
            Image(systemName: "folder")
            TextField("New Group", text: $taskGroup.title)
        }
    }
}

#Preview {
    TaskGroupRow(taskGroup: CDTaskGroup.example)
}
