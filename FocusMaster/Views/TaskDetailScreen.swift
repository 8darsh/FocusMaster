//
//  TaskDetailScreen.swift
//  FocusMaster
//
//  Created by Adarsh Singh on 20/05/24.
//

import SwiftUI
import SwiftData
struct TaskDetailScreen: View {
    @State var taskTitle: String = ""
    @State var deadlineTime: Date = Date()
    @State var taskDescription: String = ""
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    let task: TaskModel
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Title", text: $taskTitle)
                        .padding()
                    VStack {
                        Label("Deadline", systemImage: "clock.fill")
                            .bold()
                        DatePicker("Time", selection: $deadlineTime, displayedComponents: .hourAndMinute)
                            .bold()
                    }
                    .padding()
                    TextField("Description", text: $taskDescription)
                        .padding()
                }
                Section {
                    Button("Update") {
                        task.title = taskTitle
                        task.descript = taskDescription
                        task.deadline = deadlineTime
                        do {
                            try context.save()
                            dismiss() // Dismiss the view after updating
                        } catch {
                            print(error.localizedDescription)
                        }
                        dismiss()
                    }
                }
            }
            .onAppear {
                taskTitle = task.title
                taskDescription = task.descript
                deadlineTime = task.deadline
            }
        }.navigationTitle("Update Tasks")
    }
}

#Preview {
    NavigationStack{
        TaskDetailScreen(task:(TaskModel(title: "Waling", descript: "5km", deadline: .now)))
    }
}
