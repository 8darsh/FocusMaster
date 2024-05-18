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
    var body: some View {
        
        Form{
            Text("Add Tasks")
                .font(.title2)
                
                .bold()
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
                    
                }
            }
        }
            
        
    }
    
}

#Preview {
    AddTasks()
}
