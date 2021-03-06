//
//  AppNavigationHandler.swift
//  iOS POC
//
//  Created by NanduV on 02/03/22.
//

import Foundation
import UIKit

struct AppNavigationHandler{
    
    
    //Login Screen navigation
    static func goToLoginScreen(currentController: UIViewController) {
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.storyBoardName, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as! LoginViewController
        newViewController.modalPresentationStyle = .fullScreen
        weak var presentingViewController = currentController.presentingViewController
        currentController.dismiss(animated: true, completion: {
            presentingViewController?.present(newViewController, animated: false, completion: nil)
        })
       }
    
    // Home Screen navigation
    static func goToHomeScreen(currentController: UIViewController) {
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.storyBoardName, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as UIViewController
        newViewController.modalPresentationStyle = .fullScreen
        currentController.present(newViewController, animated: false, completion: nil)
    }
    
    //Profile Screen navigation
    static func goToProfileScreen(currentController: UIViewController) {
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.storyBoardName, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.profileViewController) as UIViewController
        newViewController.modalPresentationStyle = .fullScreen
        weak var presentingViewController = currentController.presentingViewController
        currentController.dismiss(animated: true, completion: {
            presentingViewController?.present(newViewController, animated: false, completion: nil)
        })
        
    }
    
    //Register Screen navigation
    static func goToRegisterScreen(currentController: UIViewController) {
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.storyBoardName, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.registerViewController) as UIViewController
        newViewController.modalPresentationStyle = .fullScreen
        currentController.present(newViewController, animated: false, completion: nil)
    }
    
    // go to weather screen
    static func goToWeatherScreen(currentController: UIViewController) {
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.storyBoardName, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.weatherViewController) as UIViewController
        newViewController.modalPresentationStyle = .fullScreen
        weak var presentingViewController = currentController.presentingViewController
        currentController.dismiss(animated: true, completion: {
            presentingViewController?.present(newViewController, animated: false, completion: nil)
        })
        
    }
}
