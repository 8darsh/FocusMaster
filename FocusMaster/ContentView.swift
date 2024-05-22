//
//  ContentView.swift
//  FocusMaster
//
//  Created by Adarsh Singh on 17/05/24.
//

import SwiftUI
import SwiftData
import UserNotifications
struct ContentView: View {
    @State private var isPresented: Bool = false
    @State private var isPresentedSettings:Bool = false
    @Query private var tasks:[TaskModel]
    @StateObject private  var settings = TimerSettings()

    var body: some View{
        NavigationStack{
            VStack{
                TimerView(settings: settings)
                
            }
            
            
            
            .toolbar{
                ToolbarItem(placement: .bottomBar) {
                    NavigationLink(destination: TaskView(tasks: tasks)) {
                        Label("Tasks", systemImage: "list.bullet.rectangle")
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    NavigationLink(destination: SettingsView(settings: settings)) {
                        Image(systemName: "gear")
                    }
                }
            }
            
        }.onAppear{
            requestNotificationPermission()
        }
       
    }
    
    func requestNotificationPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { granted, error in
            if let error = error {
                print("Error requesting notification permission: \(error.localizedDescription)")
            }
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
        
        UNUserNotificationCenter.current().delegate = NotificationDelegate.shared
    }
    
        
    
}

#Preview {
    NavigationStack{

        ContentView()
    }
}
