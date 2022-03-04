//
//  Utilities.swift
//  iOS POC
//
//  Created by NanduV on 01/03/22.
//

import Foundation
import UIKit
import SideMenu

class Utilities {
    // setup sidemenu
    static func setUpSideMenu(_ sideMenu: inout SideMenuNavigationController?, currentVC: UIViewController){
        sideMenu = SideMenuNavigationController(rootViewController: MenuListController())
        
        sideMenu?.leftSide = true
        sideMenu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: currentVC.view)
    }
}
