//
//  GeofencingViewMode.swift
//  iOS POC
//
//  Created by NanduV on 04/03/22.
//

import Foundation
import CoreLocation

class HomeViewModel: NSObject {
    
    let locationManager = CLLocationManager()
    var geofenceRegionCenter: CLLocationCoordinate2D?
    var geofenceRegion: CLCircularRegion?
    
    
    func startMonitoring() {
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.geofenceRegionCenter = CLLocationCoordinate2D(
            latitude: Constants.locationData.testLatitude,
            longitude: Constants.locationData.testLogitude
        )

        /* Create a region centered on desired location,
           choose a radius for the region (in meters)
           choose a unique identifier for that region */
        self.geofenceRegion = CLCircularRegion(center: geofenceRegionCenter!,
                                              radius: Constants.locationData.radius,
                                              identifier: Constants.locationData.locationIdentifier)
        
        geofenceRegion!.notifyOnEntry = true
        geofenceRegion!.notifyOnExit = true
        
//        self.currentState()
    
    }
    
    func currentState() {
        self.locationManager.requestState(for: geofenceRegion!)
    }
    
    func stopMonitoring() {
        self.locationManager.stopMonitoring(for: geofenceRegion!)
    }
}
extension HomeViewModel: CLLocationManagerDelegate {
    
    // called when user Exits a monitored region
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            // Do what you want if this information
            print("user exited -\(region)")
            NotificationCenter.default.post(name: .locationUpdate, object:Constants.notificationName.myObject , userInfo: [Constants.notificationName.homeViewController: Constants.locationData.outsideHome])
            appDelegate.scheduleNotification(titleText: Constants.locationData.exitingRegion, bodyText: Constants.locationData.locationIdentifier)
        }
    }
    
    // called when user Enters a monitored region
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            // Do what you want if this information
            print("user entered -\(region)")
            NotificationCenter.default.post(name: .locationUpdate, object: Constants.notificationName.myObject, userInfo: [Constants.notificationName.homeViewController: Constants.locationData.insideHome])
            appDelegate.scheduleNotification(titleText: Constants.locationData.enteringRegion, bodyText: Constants.locationData.locationIdentifier)
        }
    }
    
//    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
//        if state == .inside {
//            NotificationCenter.default.post(name: .locationUpdate, object: "myObject", userInfo: [Constants.notificationName.homeViewController: Constants.locationData.insideHome])
//              } else {
//                  NotificationCenter.default.post(name: .locationUpdate, object: "myObject", userInfo: [Constants.notificationName.homeViewController: Constants.locationData.outsideHome])
//              }
//
//    }
}

