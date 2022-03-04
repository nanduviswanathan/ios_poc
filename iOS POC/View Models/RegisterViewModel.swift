//
//  RegisterViewModel.swift
//  iOS POC
//
//  Created by NanduV on 04/03/22.
//

import Foundation

class RegisterViewModel {
    var firebaseManager: FirebasManger = FirebasManger()
    
    // register new user
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
}
