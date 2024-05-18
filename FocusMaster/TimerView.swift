//
//  TimerView.swift
//  FocusMaster
//
//  Created by Adarsh Singh on 17/05/24.
//

import SwiftUI
import Combine
import AVFoundation
struct TimerView: View {
    @State private var timerText: String = "00:00"
    @State private var isRunning: Bool = false
    @State private var elapsedTime: Int = 0
    @State private var alert: Bool = false
    @State private var timerCancellable: AnyCancellable?

    var body: some View {
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
                    
                }.font(.title3)
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

                        
                    }.font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                        .transition(.opacity)
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
                if(minutes >= 25){
                    alert = true
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
    
   
    
}

#Preview {
    TimerView()
}
