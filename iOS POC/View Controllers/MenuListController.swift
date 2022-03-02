//
//  MenuListController.swift
//  iOS POC
//
//  Created by NanduV on 25/02/22.
//

import Foundation
import UIKit

class MenuListController: UITableViewController {
    var items = [Constants.SideMenuItems.homeMenu,Constants.SideMenuItems.profileMenu,Constants.SideMenuItems.locationMenu,Constants.SideMenuItems.nearbyMenu,Constants.SideMenuItems.logoutMenu]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleTableView(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        Utilities.styleTableView(cell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("selected " + items[indexPath.row] + "\(indexPath.row)")
        
        switch (indexPath.row) {
        case 0:
            print("Home page")
            
            AppNavigationHandler.goToHomeScreen(currentController: self)
            break
            
        case 1:
            print("profile")
            
            AppNavigationHandler.goToProfileScreen(currentController: self)
            break

        case 2:
            print("location")
//            showToast(message: "sample is herbdkfhagsdfgadsjfghdsafgldsfdsf", font: .systemFont(ofSize: 12.0))
            break

        case 3:
            print("Nearby")
            break
        case 4:
            print("logout")
           showConfirmation()
            break

        default:
            print("Have you done something new?")
            break
        }
    }
    
    // show logout confirmation
    func showConfirmation(){
        presentAlertWithTitle(title: nil, message: Constants.CustomStrings.logoutConfirmation, options: Constants.AlertOptions.okButton, Constants.AlertOptions.cancelButton) { (option) in
                   print("option: \(option)")
                   switch(option) {
                       case Constants.AlertOptions.okButton:
                       self.logout()
                           break
                       case Constants.AlertOptions.cancelButton:
                           print("cancel button pressed")
                           break
                       default:
                           break
                   }
               }

    }
    
    
    // logout currently logged in user
    func logout(){
        AuthViewModel().logOutUser(){[weak self] (success) in
                        guard let `self` = self else { return }
                
                        if (success) {
                            print("success")
                            AppNavigationHandler.goToLoginScreen(currentController: self)
                        }
                    }
    }
    

}



