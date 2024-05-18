//
//  TaskView.swift
//  FocusMaster
//
//  Created by Adarsh Singh on 18/05/24.
//

import SwiftUI

struct TaskView: View {
    private var currentDate: Date?
    @State var showSheet: Bool = false
    var body: some View {
        NavigationStack{
            ScrollView{

                Section{
                    Text(Date.now, style: .date)
                        .bold()
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                .padding()
            }
            
  
        }.navigationTitle("Today's Tasks")
            
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus",action: {
                        showSheet = true
                    })
                }
            }
            .sheet(isPresented: $showSheet, content: {
                AddTasks()
            })
    }
    
}


#Preview {
    NavigationStack{
        TaskView()
    }
}
