//
//  AlertSounds.swift
//  JgnKeluar
//
//  Created by Christian Aldrich Darrien on 24/05/24.
//

import Foundation
import AVFoundation

class AlertSounds{
    private var audioPlayer : AVAudioPlayer?
    
    func playMusic(_ title : String){
        guard let soundURL = Bundle.main.url(forResource: title, withExtension: "mp3") else {
            return
        }
        do{
    //                print("masuk play sound")
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.setVolume(10.0, fadeDuration: 0)
    //            audioPlayer?.rate = 2.0
            audioPlayer?.play()
        }catch{
            print("error playing sound: \(error.localizedDescription)")
        }
    }
    
    func stopMusic(){
        audioPlayer?.stop()
        print("alert stopped")
    }
}
