//
//  WatchConnector.swift
//  JgnKeluar
//
//  Created by Christian Aldrich Darrien on 24/05/24.
//

import Foundation
import WatchConnectivity


class WatchConnector: NSObject, WCSessionDelegate{
    
//    var session :WCSession

//    static let sharedStatus = locationScanner()
//    var distance = locationScanner().distance
    static let shared = WatchConnector()
    
    override init() {
        super.init()
        activateSession()
    }
    
    func activateSession(){
        if WCSession.isSupported() {
                    let session = WCSession.default
                    session.delegate = self
                    session.activate()
                }
    }
    
    func sendStatusUpdate(status: String) {
        print("masuk send status")
            if WCSession.default.isReachable {
                WCSession.default.sendMessage(["status": status], replyHandler: nil, errorHandler: { error in
                    print("Error sending message: \(error)")
                })
                print("Message sent: \(status)")
            } else {
                
                print("Watch is not reachable")
            }
        }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
            //activation completion
        print("iOS: WCSession activated with state: \(activationState)")
               if let error = error {
                   print("iOS: WCSession activation error: \(error.localizedDescription)")
               }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let status = message["status"] as? String {
                    print("iOS: Received status from watch: \(status)")
                }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
            //stelah inactive
        print("inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
    
//    session
    
}
