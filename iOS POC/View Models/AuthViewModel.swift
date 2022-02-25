//
//  AuthViewModel.swift
//  iOS POC
//
//  Created by NanduV on 25/02/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import UIKit

class AuthViewModel{
    
    // register new user
    
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
    
    // sign in with email and password
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
    
    
    // sign out current user
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



//func createNewUser(name: String, email: String, phone: String, photo: UIImage, password: String, onCompletion: @escaping (Bool, RequestErrors?) -> Void) {
//    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
//        if let error = error {
//            print("Login error: \(error.localizedDescription)")
//            onCompletion(false, .authError)
//            return
//        }
//
//        let imageName = UUID().uuidString
//        let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
//
//        guard let uid = result?.user.uid else { return }
//
//        if let uploadData = photo.jpegData(compressionQuality: 0.1) {
//            storageRef.putData(uploadData, metadata: nil, completion: { (_, error) in
//                if let error = error {
//                    print(error)
//                    return
//                }
//                storageRef.downloadURL(completion: { (url, error) in
//                    if let error = error {
//                        print(error)
//                        return
//                    }
//                    guard let photoUrl = url else { return }
//                    let values = ["displayName": name, "email": email, "phoneNumber": phone, "photoURL": photoUrl.absoluteString]
//                    let ref = Database.database().reference()
//                    let usersReference = ref.child("users").child(uid)
//                    usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
//                        if err != nil {
//                            print(err!)
//                            return
//                        }
//                        User.shared = User(uid: uid, displayName: name, email: email, phoneNumber: phone, photoURL: photoUrl)
//                        onCompletion(true, nil)
//                    })
//                })
//            })
//        }
//    }
