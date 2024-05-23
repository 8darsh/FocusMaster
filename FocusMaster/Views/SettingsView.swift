//
//  SettingsView.swift
//  FocusMaster
//
//  Created by Adarsh Singh on 22/05/24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settings: TimerSettings
    
    var body: some View {
        NavigationStack{
            List{
                Picker("Session Duration", selection: $settings.focusTime) {
                    ForEach(1..<60,id: \.self){ time in
                        Text("\(time)")
                    }
                }.pickerStyle(.menu)
                
                Toggle(isOn: $settings.modeUi, label: {
                    Text("Appearence")
                    
                })
                
                
                
            }.padding(.top)
        }.navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack{
        let setting = TimerSettings()
        SettingsView(settings: setting)
    }
}
