//
//  MenuListController.swift
//  iOS POC
//
//  Created by NanduV on 25/02/22.
//

import Foundation
import UIKit

class MenuListController: UITableViewController {
    var items = ["Profile","Location", "NearBy", "Logout"]
    
    let darkColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("selected " + items[indexPath.row] + "\(indexPath.row)")
        
        switch (indexPath.row) {
        case 0:
            print("profile")

        case 1:
            print("location")

        case 2:
            print("Nearby")
        case 3:
            print("logout")
            
           showAlert()

//
        default:
            print("Have you done something new?")
        }
    }
    
    func showAlert(){
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to logout?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            self.logout()
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func logout(){
        AuthViewModel().signOutUser(){[weak self] (success) in
                        guard let `self` = self else { return }
                
                        if (success) {
                            self.dismiss(animated: true, completion: nil)
                            print("success")
                            self.showToast(message: "You have successfully logged out!", font: .systemFont(ofSize: 12.0))
                        }
//        User was sucessfully logged Out.
                    }
    }
    

}
