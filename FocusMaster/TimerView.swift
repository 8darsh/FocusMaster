//
//  TimerView.swift
//  FocusMaster
//
//  Created by Adarsh Singh on 17/05/24.
//

import SwiftUI
import Combine
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
                Button(action: startTimer) {
                    Text("Start")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(isRunning)
                
                Button(action: stopTimer) {
                    Text("Stop")
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(!isRunning)
                
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
                if(minutes == 25){
                    alert = true
                }
                let seconds = elapsedTime % 60
                timerText = String(format: "%02d:%02d", minutes, seconds)
            }
    }
    
    func stopTimer() {
        isRunning = false
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
   
    
}

#Preview {
    TimerView()
}
