//
//  HomeViewController.swift
//  iOS POC
//
//  Created by NanduV on 22/02/22.
//

import Foundation
import UIKit
import SideMenu

class HomeViewController: UIViewController {
    
    var menu:SideMenuNavigationController?
    
    var authVM: AuthViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        authVM = AuthViewModel()
        // Define the menu
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)

        
        print("Home started");
    }

    // hamburgger menu tap
    @IBAction func didTapHamburger(_ sender: UIBarButtonItem) {
        present(menu!,animated: true)
    }
    
    
}

