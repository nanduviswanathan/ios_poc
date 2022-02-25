//
//  AuthViewModel.swift
//  iOS POC
//
//  Created by NanduV on 25/02/22.
//

import Foundation
import UIKit

class AuthViewModel{
    
    // register new user
    
    var firebaseManager: FirebasManger = FirebasManger()
    
    func registerUser(photo: UIImage,firstName:String, lastName:String?,age:Int, email: String, password: String,  completionBlock: @escaping (_ success: Bool) -> Void) {
        firebaseManager.createUser(photo: photo, firstName: firstName, lastName: lastName, age: age, email: email, password: password)  {(success) in
        
            if (success) {
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
}
    
    // sign in with email and password
    func logIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool, _ msg: String) -> Void) {
        print("data here " + email + pass )
        firebaseManager.signIn(email: email, pass: pass) {(success,msg) in
        
            if (success) {
            completionBlock(true,msg)
                
            } else {
               completionBlock(false,msg)
            }
           

        }
    }
    
    
    // sign out current user
    func logOutUser(completionBlock: @escaping (_ success: Bool) -> Void){
        firebaseManager.signOutUser(){ (success) in
           if (success) {
               completionBlock(true)
           } else {
               completionBlock(false)
           }
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
