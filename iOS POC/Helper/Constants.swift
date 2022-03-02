//
//  Constants.swift
//  iOS POC
//
//  Created by NanduV on 01/03/22.
//

import Foundation

struct Constants {
    
    struct Storyboard {
        
        static let storyBoardName = "Main"
        static let homeViewController = "HomeVC"
        static let registerViewController = "RegisterVC"
        static let loginViewController = "LoginVC"
        static let profileViewController = "ProfileVC"
        
    }
    
    struct CustomStrings {
        static let userCreationSucces = "User was sucessfully created."
        static let userCreationfail = "There was an error."
        static let logoutConfirmation = "Are you sure you want to logout?"
        static let loginSucess = "Success: User was sucessfully logged in."
        static let userDisabled = "Error: The user account has been disabled by an administrator."
        static let operationNotAllowed = "Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console."
        static let wrongPassword = "Error: The password is invalid or the user does not have a password."
        static let invalidEmail = "Error: Indicates the email address is malformed."
    }
    
    struct SideMenuItems {
        static let homeMenu = "Home"
        static let profileMenu = "Profile"
        static let locationMenu = "Location"
        static let nearbyMenu = "NearBy"
        static let logoutMenu = "Logout"
    }
    
    struct AlertOptions {
        static let okButton = "OK"
        static let cancelButton = "cancel"
    }
    
    
}
