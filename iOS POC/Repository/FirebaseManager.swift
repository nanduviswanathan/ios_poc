//
//  FirebaseManager.swift
//  iOS POC
//
//  Created by NanduV on 25/02/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class FirebasManger {
    
    // Register a new User
    func createUser(photo: Data?,firstName:String, lastName:String?,age:Int, email: String, password: String,  completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
            // Check for errors
            if err != nil {
                
                completionBlock(false)
            }
            else {
                
                // User was created successfully, now store the first name and last name
                let db = Firestore.firestore()
                
                guard let uid = result?.user.uid else { return }
                let imageName = UUID().uuidString
                let storageRef = Storage.storage().reference().child("users").child("\(uid)").child("\(imageName).jpg")


                if let uploadData = photo {
                    storageRef.putData(uploadData, metadata: nil, completion: { (_, error) in
                        if let error = error {
                            print(error)
                            return
                        }
                        storageRef.downloadURL(completion: { (url, error) in
                            if let error = error {
                                print(error)
                                return
                            }
                            guard let photoUrl = url else { return }
                            
                            print("photo url is -\(photoUrl)")
                            
                                db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName ?? "", "age":age , "uid": uid ]) { (error) in
                                
                                if error != nil {
                                    // Show error message
                                    print("error saving user data")
                                }
                                
                                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                                changeRequest?.photoURL = photoUrl
                                changeRequest?.commitChanges { error in
                                    if let error = error {
                                        print(error)
                                        return
                                    }
                                }
                            }
                            

                        })
                    })
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
                    errorData = Constants.CustomStrings.operationNotAllowed
                    break
                case .userDisabled:
                    errorData = Constants.CustomStrings.userDisabled
                    break
                case .wrongPassword:
                    errorData = Constants.CustomStrings.wrongPassword
                    break
                case .invalidEmail:
                    errorData = Constants.CustomStrings.invalidEmail
                    break
                default:
                    errorData = "\(error.localizedDescription)"
                    break
                }
                completionBlock(false, errorData)
              } else {
                print("User signed in successfully")
                  completionBlock(true, Constants.CustomStrings.loginSucess )
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
    
//
      
    func getUserData( completionBlock: @escaping (_ success: Bool, _ data: UserDataModel?) -> Void) {
        let docRef = Firestore.firestore()
                    .collection("users")
                    .whereField("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "")

                 // Get data
                 docRef.getDocuments { (querySnapshot, err) in
                     if let err = err {
                         print(err.localizedDescription)
                         completionBlock(false,nil)
                     } else if querySnapshot!.documents.count != 1 {
                         print("More than one document or none")
                         completionBlock(false,nil)
                     } else {
                         let document = querySnapshot!.documents.first
                         let dataDescription = document?.data()
//
//                         guard let firstname = dataDescription?["firstname"] else { return }
//                         print(firstname)
//                         print("data is  => \(dataDescription)")
                         let jsonData = try! JSONSerialization.data(withJSONObject: dataDescription)
                         let userData = try? JSONDecoder().decode(UserDataModel.self, from: jsonData)
                         completionBlock(true,userData)
                     }
                 }
    }
    
    //get current user email and dp
    func emailAndProfilePic() -> (email: String?, pic: URL?){
        let firebaseUser = Auth.auth().currentUser
        return (firebaseUser?.email,firebaseUser?.photoURL)
    }
    
    // load image
    func loadprofileImage( completionBlock: @escaping (_ data: Data?) -> Void) {
        guard let link = Auth.auth().currentUser?.photoURL else { return }
        let Ref = Storage.storage().reference(forURL: link.absoluteString)
        Ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("Error: Image could not download!")
                completionBlock(nil)
            } else {
                completionBlock(data)
            }
        }
    }
}
