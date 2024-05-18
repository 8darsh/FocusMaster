//
//  SoundManager.swift
//  FocusMaster
//
//  Created by Adarsh Singh on 18/05/24.
//

import Foundation
import AVFoundation

class SoundManager{
    
    static let shared = SoundManager()
    private var player: AVAudioPlayer?
    
    
    func playSound(named soundName: String){
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else{
            print("Sound file not found")
            return
        }
        
        do{
            
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }
        catch{
            print("Failed to play sound: \(error.localizedDescription)")
        }
    }
    func stopSound(){
        player?.stop()
    }
}
