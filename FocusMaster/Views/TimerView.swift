//
//  TimerView.swift
//  FocusMaster
//
//  Created by Adarsh Singh on 17/05/24.
//

import SwiftUI
import Combine
import AVFoundation
import UserNotifications
struct TimerView: View {
    @State private var timerText: String = "00:00"
    @State private var isRunning: Bool = false
    @State private var elapsedTime: Int = 0
    @State private var alert: Bool = false
    @State private var timerCancellable: AnyCancellable?
    
    @ObservedObject var settings: TimerSettings
    
    var body: some View {
        NavigationStack{
            VStack {
                Text(timerText)
                    .font(.largeTitle)
                    .padding()
                
                
                HStack {
                    Button(!isRunning ? "Start"
                           : "Stop") {
                        withAnimation {
                            isRunning.toggle()
                        }
                        
                        if(isRunning){
                            startTimer()
                        }else{
                            stopTimer()
                        }
                        
                    }.font(.subheadline)
                        .padding()
                        .fontWeight(.bold)
                        .background(Color.red)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                    
                    if(!isRunning){
                        Button("Reset", systemImage: "arrow.circlepath") {
                            withAnimation {
                                elapsedTime = 0
                                timerText = "00:00"
                                stopTimer()
                            }
                            
                            
                        }.font(.subheadline)
                            .padding()
                            .background(Color.green)
                            .foregroundStyle(.white)
                            .clipShape(.capsule)
                            .transition(.opacity)
                    }
                }
                
                
            }
        }
        
        
    }
    
    func startTimer() {
        
        isRunning = true
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                elapsedTime += 1
                let minutes = elapsedTime / 60
                if(minutes >= settings.focusTime){
                    alert = true
                    self.scheduleNotification(in: 5, title: "Time Finished", body: "Your Focus time is over Time for a Break!")
                    SoundManager.shared.playSound(named: "stop")
                    
                        
                }
                let seconds = elapsedTime % 60
                timerText = String(format: "%02d:%02d", minutes, seconds)
            }
    }
    
    func stopTimer() {
        isRunning = false
        timerCancellable?.cancel()
        timerCancellable = nil
        
        if(alert){
            elapsedTime = 0
            timerText = "00:00"
            SoundManager.shared.stopSound()
        }
    }
    
    func scheduleNotification(in seconds:TimeInterval, title: String,body: String){
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .default
        content.body = body
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request){ error in
            
            if let error = error{
                print("Error scheduling Notifications: \(error.localizedDescription)")
            }
            
        }
    }
    
   
    
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate{
    static let shared = NotificationDelegate()
    
    override init() {
        super.init()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}

#Preview {
    
    TimerView(settings: TimerSettings())
}
