//
//  MenuListController.swift
//  iOS POC
//
//  Created by NanduV on 25/02/22.
//

import Foundation
import UIKit

class MenuListController: UITableViewController {
    var items = [Constants.SideMenuItems.homeMenu,Constants.SideMenuItems.profileMenu,Constants.SideMenuItems.weatherMenu,Constants.SideMenuItems.logoutMenu]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = Constants.Colors.darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.SideMenuItems.cellIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.SideMenuItems.cellIdentifier , for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = Constants.Colors.darkColor
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
            print("Weather")
            AppNavigationHandler.goToWeatherScreen(currentController: self)
            break
        case 3:
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
        LoginViewModel().logOutUser(){[weak self] (success) in
                        guard let `self` = self else { return }
                
                        if (success) {
                            print("success")
                            AppNavigationHandler.goToLoginScreen(currentController: self)
                        }
                    }
    }
    

}
