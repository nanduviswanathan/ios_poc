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
import FirebaseAuth

class HomeViewController: UIViewController {
    
//    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    var menu:SideMenuNavigationController?

    
    @IBOutlet weak var myLocationLabel: UILabel!
    
    
    
    var homeVM: HomeViewModel?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        homeVM = HomeViewModel()
        Utilities.setUpSideMenu(&menu, currentVC: self)
        homeVM?.startMonitoring()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUiFromLocation), name: .locationUpdate, object: nil)
        
    }
    // hamburgger menu tap
    @IBAction func didTapHamburger(_ sender: UIBarButtonItem) {
        present(menu!,animated: true)
    }
    
    // update ui
    @objc func updateUiFromLocation(notification: Notification) {
        let value = notification.userInfo?[Constants.notificationName.homeViewController] as? String
        myLocationLabel.text = value!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        homeVM?.stopMonitoring()
    }
    
}





