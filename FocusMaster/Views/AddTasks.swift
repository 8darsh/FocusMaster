//
//  AddTasks.swift
//  FocusMaster
//
//  Created by Adarsh Singh on 19/05/24.
//

import SwiftUI

struct AddTasks: View {
    
    @State var taskTitle: String = ""
    @State var deadlineTime: Date = Date()
    @State var taskDescription: String = ""
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        
        NavigationStack {
            Form{
                Text("Add Task")
                    .font(.title3)
                    .bold()
                    .padding()
                Section{
                    TextField("Title", text: $taskTitle)
                        .padding()
                    VStack{
                        Label("Dedline", systemImage: "clock.fill")
                            .bold()
                        DatePicker("Time", selection: $deadlineTime, displayedComponents: .hourAndMinute)
                            .bold()
                            
                                
                    }.padding()
                        
                    TextField("Description", text: $taskDescription)
                        .padding()
                }
                Section{
                    Button("Save") {
                        
                        let task = TaskModel(title: taskTitle, descript: taskDescription, deadline: deadlineTime)
                        context.insert(task)
                        
                        do{
                            try context.save()
                        }
                        catch{
                            print(error.localizedDescription)
                        }
                        dismiss()
                    }
                }
            }
        }.navigationTitle("Add Tasks")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close"){
                        dismiss()
                    }
                }
            }
            
        
    }

}

#Preview {
    NavigationStack{
        AddTasks()
    }
}
