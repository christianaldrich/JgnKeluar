//
//  15MinTimer.swift
//  JgnKeluar
//
//  Created by Christian Aldrich Darrien on 24/05/24.
//

import Foundation

class Start15Timer{
    var lastDetectionDate : Date?
//    var lastDetectionTime : Date?
    
    var timer : Timer?
//    var beaconManager = WatchToiOSConnector()
    var soundManager = AlertSounds()
    private var debounce: Timer?
    
    func startTimer(){
        print("masuk timer")
//        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 100, target: self, selector: #selector(timerFired), userInfo: nil, repeats: false)
        print("keluar timer")
    }
    
    @objc func timerFired() {

            print("Beacon not detected for 15 minutes")
            soundManager.playMusic("pedro")
            print("something")
    }
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer(){
        
        debounce?.invalidate()
        debounce = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(performReset), userInfo: nil, repeats: false)

    }
    
    @objc private func performReset() {
            stopTimer()
            lastDetectionDate = Date()
            startTimer()
    }
    
    
}
