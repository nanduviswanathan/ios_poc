//
//  ProfileViewController.swift
//  iOS POC
//
//  Created by NanduV on 28/02/22.
//

import Foundation
import UIKit
import SideMenu

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
        Utilities.setUpSideMenu(&menu, currentVC: self)
        
        print("Profile Started started");
        
   
    }
    
    @IBAction func didTapHamburggerButton(_ sender: UIBarButtonItem) {
        present(menu!,animated: true)
    }
    
    // update ui according to the user data
    func updateUI(){
        authVM?.getUserInfo() {[weak self] (success,userData) in
            guard let `self` = self else { return }
            if (success) {
                self.firstNameLabel.text = (": \(userData!.firstname)")
                self.lastnameLabel.text = (": \(userData!.lastname)")
                self.ageLabel.text = (": \(userData!.age)")
                self.emailLabel.text = (": \(self.authVM?.getEmailAndPic().email ?? "")")
                
                //get image from firebase
                self.authVM?.loadImage(){(imageData) in
                    if imageData != nil {
                        self.profileImageView.image = UIImage(data: imageData!)
                    } else {
                        print("Error: Image could not download!")
                    }
                    self.loaderView.isHidden = true
                }
            }
        }
    }
}
