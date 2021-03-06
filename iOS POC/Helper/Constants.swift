//
//  Constants.swift
//  iOS POC
//
//  Created by NanduV on 01/03/22.
//

import Foundation
import UIKit

struct Constants {
    
    struct Storyboard {
        
        static let storyBoardName = "Main"
        static let homeViewController = "HomeVC"
        static let registerViewController = "RegisterVC"
        static let loginViewController = "LoginVC"
        static let profileViewController = "ProfileVC"
        static let weatherViewController  = "WeatherVC"
        
    }
    
    struct ErrorText{
        static let emailError = "Please enter a valid email address"
        static let passwordError = "password must contain 6 characters"
        static let nameError = "Please enter a valid name"
        static let ageError = "Please enter a valid age"
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
        static let cityError = "Error: City doesn't Exist"
    }
    
    struct SideMenuItems {
        static let homeMenu = "Home"
        static let profileMenu = "Profile"
        static let weatherMenu = "Weather"
        static let logoutMenu = "Logout"
        static let cellIdentifier = "menuCellItem"
    }
    
    struct AlertOptions {
        static let okButton = "OK"
        static let cancelButton = "cancel"
    }
    
    struct Colors{
        static let darkColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        static let backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
    }
    
    struct locationData {
        
        static let locationIdentifier = "Home"
        static let enteringRegion  = "Entering Region"
        static let exitingRegion = "Exiting Region"
        
        static let insideHome = "Hi, You are inside Home"
        static let outsideHome = "Hi, You are outside Home"
        
        static let testLatitude = 10.022659116870798
//        37.33233141
        static let testLogitude = 76.34480352262618
//        -122.0312186
        
        static let   radius = 100.00
        
    }
    
    struct Image {
        static let personImage = UIImage(systemName: "person.fill")
    }
    
    // sample for exiting lat = 37.342331
    //    -122.031219
    
    struct notificationName {
        static let locationUpdateString = "locationUpdate"
        
        static let homeViewController = "HOME_VIEWCONTROLLER"
        
        static let myObject  = "myObject"
    }
    
    struct weatherInfo {
       static let weatherURL = "https://api.openweathermap.org/data/2.5/onecall?exclude=current,hourly,minutely&units=metric&appid="
       static let appId = "99dcc091f4bde9aaa3d87ebd82e0a85c"
        
        static let tempInC = "temp in ??C"
        static let weatherIn = "Weather in "
    }
    
}
var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
