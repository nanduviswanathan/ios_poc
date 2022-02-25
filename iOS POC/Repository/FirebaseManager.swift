//
//  FirebaseManager.swift
//  iOS POC
//
//  Created by NanduV on 25/02/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirebasManger {
    
    // Register a new User
    func createUser(photo: UIImage,firstName:String, lastName:String?,age:Int, email: String, password: String,  completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
            // Check for errors
            if err != nil {
                
                completionBlock(false)
            }
            else {
                
                // User was created successfully, now store the first name and last name
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName ?? "", "age":age , "uid": result!.user.uid ]) { (error) in
                    
                    if error != nil {
                        // Show error message
                        print("error saving user data")
                    }
                }
                completionBlock(true)
            }
        
    }
}
    
    //sign in using email and password
    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool, _ msg: String) -> Void) {
        print("data here " + email + pass )
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error as NSError? {
                var errorData = ""
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                    
                    errorData = " Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console."
                    break

                case .userDisabled:
                    errorData = " Error: The user account has been disabled by an administrator."
                    break
                case .wrongPassword:
                    errorData = " Error: The password is invalid or the user does not have a password."
                    break
                case .invalidEmail:
                    errorData = "Error: Indicates the email address is malformed."
                    break
                default:
                    errorData = "\(error.localizedDescription)"
                    break
                }
                completionBlock(false, errorData)
              } else {
                print("User signs in successfully")
                let userInfo = Auth.auth().currentUser
                let email = userInfo?.email
                  print("user info email " + email! )
                  completionBlock(true,"Success: User was sucessfully logged in." )
              }
        }
    }

    
    // signout user
    func signOutUser(completionBlock: @escaping (_ success: Bool) -> Void){
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        completionBlock(true)
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
        completionBlock(false)
    }
    }
}
