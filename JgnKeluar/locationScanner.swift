//
//  locationScanner.swift
//  JgnKeluar
//
//  Created by Christian Aldrich Darrien on 24/05/24.
//

import Foundation
import CoreLocation
//import SwiftUI

class locationScanner : NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager : CLLocationManager?
    @Published var distance : String = "unknown"
//    @StateObject var 
    var updateTimer : Timer?
    var interval : TimeInterval = 10
    
    
    
    override init(){
        locationManager = CLLocationManager()
        super.init()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
//        status = "red"
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways{
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                if CLLocationManager.isRangingAvailable(){
                    startScanning()
                }
            }
        }
    }
    
    func startScanning(){
        let uuid = UUID(uuidString: "AC2E78CB-B96D-443A-8641-9C4D8F41FDE3")!
        
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: 0, minor: 0, identifier: "BeaconTesting")
        
//        print("kekirim")
        WatchConnector.shared.sendStatusUpdate(status: distance)
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)
        
        
        
    }
    
    func update(distance: CLProximity){
        
        switch distance{
        case .far:
            self.distance = "far"
            WatchConnector.shared.sendStatusUpdate(status: self.distance)
        case .near:
            self.distance = "near"
            WatchConnector.shared.sendStatusUpdate(status: self.distance)
        case .immediate:
            self.distance = "immediate"
            WatchConnector.shared.sendStatusUpdate(status: self.distance)
        default:
            self.distance = "unknown"
            WatchConnector.shared.sendStatusUpdate(status: self.distance)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        if let beacon = beacons.first{
            update(distance: beacon.proximity)
        }else{
            update(distance: .unknown)
        }
    }
    
    
}
