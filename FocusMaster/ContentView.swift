//
//  ContentView.swift
//  FocusMaster
//
//  Created by Adarsh Singh on 17/05/24.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @State private var isPresented: Bool = false
    @Query private var tasks:[TaskModel]
    var body: some View{
        NavigationStack{
            VStack{
                TimerView()
            }
            .navigationDestination(isPresented: $isPresented){
                TaskView(tasks: tasks)
            }
        }.navigationTitle("Focus Master")
            

            .toolbar{
                ToolbarItem(placement: .bottomBar) {
                    Button{
                        isPresented = true
                    }label: {
                        Text("Tasks")
                        Image(systemName: "list.bullet.rectangle")
                    }
                }
            }
    }
    
        
    
}

#Preview {
    NavigationStack{
        ContentView()
    }
}
