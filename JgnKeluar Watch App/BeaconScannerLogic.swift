//
//  BeaconScannerLogic.swift
//  JgnKeluar
//
//  Created by Christian Aldrich Darrien on 24/05/24.
//

import Foundation

class BeaconScannerLogic{
    var distance = WatchToiOSConnector.shared.status
    var soundManager = AlertSounds()
    
    func validate(){
        print("masuk validate")
        print(distance)
        if distance == "far" || distance == "unknown"{
            soundManager.playMusic("pedro")
        }
        else{
            soundManager.stopMusic()
        }
        
    }
    
}
