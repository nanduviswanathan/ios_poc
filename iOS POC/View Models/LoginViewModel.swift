//
//  AuthViewModel.swift
//  iOS POC
//
//  Created by NanduV on 25/02/22.
//

import Foundation

class LoginViewModel{
    
    var firebaseManager: FirebasManger = FirebasManger()
    
    
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
}
