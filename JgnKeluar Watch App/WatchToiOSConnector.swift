//
//  watchToiOSConnector.swift
//  JgnKeluar Watch App
//
//  Created by Christian Aldrich Darrien on 24/05/24.
//

import Foundation
import WatchConnectivity

class WatchToiOSConnector: NSObject, WCSessionDelegate, ObservableObject{
    
    static let shared = WatchToiOSConnector()
//    static let sharedStatus = WatchToiOSConnector()
    @Published var status: String = ""
//    @Published var sharedStatus: String = ""
    var soundManager = AlertSounds()
    var timerManager = Start15Timer()
    
    var lastDetectionDate : Date?
    var timer : Timer?
    
    var flagStatus : [String] = []
    var dateStatus : [Date] = []
    
    private var isTimerRunning : Bool = false
    private var isMusicPlaying : Bool = false
    
    override init() {
            super.init()
            activateSession()
        }
        
    func activateSession() {
            if WCSession.isSupported() {
                let session = WCSession.default
                session.delegate = self
                session.activate()
            }
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
            // Handle activation completion
        print("watchOS: WCSession activated with state: \(activationState)")
                if let error = error {
                    print("watchOS: WCSession activation error: \(error.localizedDescription)")
                }
    }
        
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let hourCall = calendar.component(.hour, from: currentDate)
        
//        print(hourCall)
        
        if hourCall >= 9 && hourCall < 17 {
            if let receivedStatus = message["status"] as? String {
                DispatchQueue.main.async {
                    self.status = receivedStatus
                    self.flagStatus.append(receivedStatus)
                    self.dateStatus.append(Date())
                    
                    print("Message: \(receivedStatus)")
                    
                    if receivedStatus == "near" || receivedStatus == "immediate"{
                        
                        
                        
                        if self.isTimerRunning{
                            self.stopTimer()
                        }
                        if self.isMusicPlaying{
                            self.soundManager.stopMusic()
                            self.isMusicPlaying = false
                        }
                        
                    }
                    else if receivedStatus == "far" || receivedStatus == "unknown"{
                        if !self.isTimerRunning {
                            self.lastDetectionDate = Date()
                            self.startTimer()
                        }
                    }
                }
            }
        }
        else{
            print("outside working hours")
        }
    
    }
    
    
    func startTimer(){
//        soundManager.stopMusic()
//        print("masuk timer")
        isTimerRunning = true
        isMusicPlaying = true
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerFired), userInfo: nil, repeats: false)
//        print("harusnya masuk fired")
    }
    
    
    //set timer jal jgn lupa, smentara 5 dtk ye
    @objc func timerFired() {
//        print("stelah 5 detik")
        let now = Date()
        
        if let lastDetectionDate = lastDetectionDate, now.timeIntervalSince(lastDetectionDate) >= 5{
            print("Beacon not detected for 15 minutes")
            soundManager.playMusic("pedro")
            isMusicPlaying = true
            print("Playing pedro")
        }
        
        isTimerRunning = false
    }
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
        isMusicPlaying = false
        soundManager.stopMusic()
    }
    
        
    func sessionReachabilityDidChange(_ session: WCSession) {
            // Handle reachability changes if needed
        print("watchOS: WCSession reachability changed to: \(session.isReachable)")
    }
        
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
            if let receivedStatus = applicationContext["status"] as? String {
                DispatchQueue.main.async {
                    self.status = receivedStatus
                    print("watchOS: Received application context from iPhone: \(receivedStatus)")
                }
            }
        
    }
    
    
//    var session :WCSession
//
//    init(session: WCSession) {
//        self.session = session
//        super.init()
//        session.delegate = self
//        session.activate()
//    }
//
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
//                
//    }
//    
//    func showStatus(){
//        
//    }
    
}
