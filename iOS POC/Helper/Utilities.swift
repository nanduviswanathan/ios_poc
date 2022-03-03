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
    
    // to close keyboard on return key pressed
    static func returnKeyFunc(_ textField: UITextField){
        textField.addTarget(nil, action:Selector(("firstResponderAction:")), for:.editingDidEndOnExit)
    }
    
    // setup sidemenu
    static func setUpSideMenu(_ sideMenu: inout SideMenuNavigationController?, currentVC: UIViewController){
        sideMenu = SideMenuNavigationController(rootViewController: MenuListController())
        
        sideMenu?.leftSide = true
        sideMenu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: currentVC.view)
    }
}
