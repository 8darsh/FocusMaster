//
//  TaskView.swift
//  FocusMaster
//
//  Created by Adarsh Singh on 18/05/24.
//

import SwiftUI
import SwiftData
struct TaskView: View {
    @State private var showSheet: Bool = false
    let tasks: [TaskModel]
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationStack {
            VStack {
                Section {
                    Text(Date.now, style: .date)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()

                List {
                    ForEach(tasks, id: \.id) { task in
                        NavigationLink(destination: TaskDetailScreen(task: task)) {
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .font(.title3)
                                Text(formattedDate(task.deadline))
                                    .font(.caption)
                            }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .navigationTitle("Today's Tasks")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                NavigationStack{
                    AddTasks()
                }
            }
        }
    }

    private func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = tasks[index]
            context.delete(task)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
      
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    NavigationStack{
        TaskView(tasks: [TaskModel(title: "dbch", descript: "sbc", deadline: .now)])
    }
}
