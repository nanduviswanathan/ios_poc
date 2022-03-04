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
    
    func registerUser(photo: Data?,firstName:String, lastName:String?,age: String, email: String, password: String,  completionBlock: @escaping (_ success: Bool, _ msg: String?) -> Void) {
        
        let fName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        let lName = lastName?.trimmingCharacters(in: .whitespacesAndNewlines)
        let userAge = age.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailId = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(fName.isEmpty) {
            completionBlock(false, Constants.ErrorText.nameError)
            return
        }
        if(userAge.isEmpty || !age.isInt) {
            completionBlock(false, Constants.ErrorText.ageError)
            return
        }
        
        if (!emailId.isValidEmail()) {
            completionBlock(false, Constants.ErrorText.emailError)
            return
        }
        if (!pass.isValidPassword()) {
            completionBlock(false, Constants.ErrorText.passwordError)
            return
        }
        firebaseManager.createUser(photo: photo, firstName: fName, lastName: lName, age: Int(userAge)!, email: emailId, password: pass)  {(success) in
        
            if (success) {
                completionBlock(true,nil)
            } else {
                completionBlock(false,nil)
            }
        }
}
    
    
    
      
    // sign in with email and password
    func logIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool, _ msg: String) -> Void) {
        
        let emailId =  email.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = pass.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (!emailId.isValidEmail() ) {
            completionBlock(false, Constants.ErrorText.emailError)
            return
            }
        if (!password.isValidPassword()) {
            completionBlock(false, Constants.ErrorText.passwordError)
            return
        }
        
        firebaseManager.signIn(email: emailId, pass: password) {(success,msg) in
        
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
