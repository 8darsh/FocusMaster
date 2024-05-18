//
//  TaskView.swift
//  FocusMaster
//
//  Created by Adarsh Singh on 18/05/24.
//

import SwiftUI

struct TaskView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                
            }
        }.navigationTitle("Tasks")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: addItems){
                        Image(systemName: "plus")
                    }
                }
            }
    }
    func addItems(){
        
    }
}


#Preview {
    TaskView()
}
