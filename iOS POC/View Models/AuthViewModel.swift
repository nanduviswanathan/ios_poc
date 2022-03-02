//
//  AuthViewModel.swift
//  iOS POC
//
//  Created by NanduV on 25/02/22.
//

import Foundation

class AuthViewModel{
    
    // register new user
    var firebaseManager: FirebasManger = FirebasManger()
    
    func registerUser(photo: Data?,firstName:String, lastName:String?,age:Int, email: String, password: String,  completionBlock: @escaping (_ success: Bool) -> Void) {
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
    
    // get user details from firestore database
    func getUserInfo(completionBlock: @escaping (_ success: Bool, _ msg: UserData?) -> Void){
        firebaseManager.getUserData() {(success,userData) in
            
            if (success) {
            completionBlock(true,userData)
                
            } else {
               completionBlock(false,userData)
            }
        }
    }
    
    //get user email and profileUrl
    func getEmailAndPic() -> (email: String?, pic: URL?){
        return firebaseManager.emailAndProfilePic()
    }
    
    //load image from firebase
    func loadImage(completionBlock: @escaping (_ data: Data?) -> Void){
        firebaseManager.loadprofileImage() {(imageData) in
            completionBlock(imageData)
        }
    }
}
