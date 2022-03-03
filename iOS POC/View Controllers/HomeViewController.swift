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
    
    var menu:SideMenuNavigationController?
    let locationManager = CLLocationManager()
    
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
        self.locationManager.requestAlwaysAuthorization()
        let geofenceRegionCenter = CLLocationCoordinate2D(
            latitude: Constants.locationData.testLatitude,
            longitude: Constants.locationData.testLogitude
        )

        /* Create a region centered on desired location,
           choose a radius for the region (in meters)
           choose a unique identifier for that region */
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter,
                                              radius: Constants.locationData.radius,
                                              identifier: Constants.locationData.locationIdentifier)
        
        geofenceRegion.notifyOnEntry = true
        geofenceRegion.notifyOnExit = true
        
        self.locationManager.startMonitoring(for: geofenceRegion)
    
    }
}





