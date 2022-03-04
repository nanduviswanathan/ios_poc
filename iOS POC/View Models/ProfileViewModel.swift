//
//  ProfileViewModel.swift
//  iOS POC
//
//  Created by NanduV on 04/03/22.
//

import Foundation

class ProfileViewModel {
    
    var firebaseManager: FirebasManger = FirebasManger()
    
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
