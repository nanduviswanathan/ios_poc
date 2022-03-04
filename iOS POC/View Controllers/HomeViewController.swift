//
//  HomeViewController.swift
//  iOS POC
//
//  Created by NanduV on 22/02/22.
//

import Foundation
import UIKit
import SideMenu
import CoreLocation

class HomeViewController: UIViewController {
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    var menu:SideMenuNavigationController?
    let locationManager = CLLocationManager()
    var geofenceRegionCenter: CLLocationCoordinate2D?
    var geofenceRegion: CLCircularRegion?
    
    @IBOutlet weak var myLocationLabel: UILabel!
    
    
    
    var authVM: AuthViewModel?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        authVM = AuthViewModel()
        Utilities.setUpSideMenu(&menu, currentVC: self)
        geofenceSettings()
        
    }
    // hamburgger menu tap
    @IBAction func didTapHamburger(_ sender: UIBarButtonItem) {
        present(menu!,animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func geofenceSettings(){
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
        
        self.locationManager.startMonitoring(for: geofenceRegion!)
    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.locationManager.stopMonitoring(for: geofenceRegion!)
   
    }
    
}

extension HomeViewController: CLLocationManagerDelegate {
    
    // called when user Exits a monitored region
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            // Do what you want if this information
            print("user exited -\(region)")
            myLocationLabel.text = Constants.locationData.outsideHome
            self.appDelegate?.scheduleNotification(titleText: Constants.locationData.exitingRegion, bodyText: Constants.locationData.locationIdentifier)
        }
    }
    
    // called when user Enters a monitored region
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            // Do what you want if this information
            print("user entered -\(region)")
            myLocationLabel.text = Constants.locationData.insideHome
            self.appDelegate?.scheduleNotification(titleText: Constants.locationData.enteringRegion, bodyText: Constants.locationData.locationIdentifier)
        }
    }
}




