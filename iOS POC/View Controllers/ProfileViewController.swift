//
//  ProfileViewController.swift
//  iOS POC
//
//  Created by NanduV on 28/02/22.
//

import Foundation
import UIKit
import SideMenu
import FirebaseAuth
import FirebaseStorage

class ProfileViewController: UIViewController {


    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var loaderView: UIView!
    
    var menu:SideMenuNavigationController?
    
    var authVM: AuthViewModel?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loaderView.isHidden = false
        authVM = AuthViewModel()
        updateUI()
        // Define the menu
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)

        
        print("Profile Started started");
        
   
    }
    
    @IBAction func didTapHamburggerButton(_ sender: UIBarButtonItem) {
        present(menu!,animated: true)
    }
    
    
    func updateUI(){
        authVM?.getUserInfo() {[weak self] (success,userData) in
            guard let `self` = self else { return }
            if (success) {
                self.firstNameLabel.text = (": \(userData!.firstname)")
                self.lastnameLabel.text = (": \(userData!.lastname)")
                self.ageLabel.text = (": \(userData!.age)")
                self.emailLabel.text = (": \(self.authVM?.getEmailAndPic().email ?? "")")
                
                //get image from firebase
                
                guard let link = self.authVM?.getEmailAndPic().pic else { return }
                
                let Ref = Storage.storage().reference(forURL: link.absoluteString)
                Ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if error != nil {
                        print("Error: Image could not download!")
                    } else {
                        self.profileImageView.image = UIImage(data: data!)
                        self.loaderView.isHidden = true
                    }
                }
            }
        }
    }
}
