//
//  RegisterViewController.swift
//  iOS POC
//
//  Created by NanduV on 22/02/22.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var firstNameErrorText: UILabel!
    @IBOutlet weak var ageErrorText: UILabel!
    @IBOutlet weak var emailErrorText: UILabel!
    @IBOutlet weak var passwordErrorText: UILabel!
    
    var authVM: AuthViewModel?
    
    var imagePicker = UIImagePickerController()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authVM = AuthViewModel()
        imagePicker.delegate = self
        
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        setUpUI()
    }

    @IBAction func didTapRegisterButton(_ sender: UIButton) {
        print("Register tapped")
        setUpUI()
        guard let firstName = firstNameTextField.text , let lastName = lastNameTextField.text,let age = ageTextField.text,let emailAddress = emailTextField.text, let password = passwordTextField.text else {
                return
            }
        if(firstName.isEmpty) {
            firstNameErrorText.isHidden = false
            return
        }
        if(age.isEmpty || !age.isInt) {
            ageErrorText.isHidden = false
            return
        }
        
        if (emailAddress.isEmpty || !emailAddress.isValidEmail()) {
            print("email error")
                emailErrorText.isHidden = false
                return
        }
        if (password.isEmpty) {
         passwordErrorText.isHidden = false
         return
        }
        
        
        authVM?.registerUser(photo:(imageView?.image)! ,firstName: firstName, lastName: lastName, age: Int(age)!, email: emailAddress, password: password) {[weak self] (success) in
            guard let `self` = self else { return }
            var message: String = ""
            if (success) {
                message = "User was sucessfully created."
            } else {
                message = "There was an error."
            }
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK Pressed")
                self.backToLoginPage()
                
            }
            alertController.addAction(okAction)
//            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }

    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        backToLoginPage()
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
       // let tappedImage = tapGestureRecognizer.view as! UIImageView
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil )
    }
    
    
    func setUpUI() {
        firstNameErrorText.isHidden = true
        ageErrorText.isHidden = true
        emailErrorText.isHidden = true
        passwordErrorText.isHidden = true
        
    }
    
    func backToLoginPage() {
        self.dismiss(animated: true, completion: nil)
    }
}


extension RegisterViewController: UIImagePickerControllerDelegate ,  UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        imageView.image = image
        dismiss(animated: true)
    }
}


//let storyBoard: UIStoryboard = UIStoryboard(name: "HTMLRenderPage", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HTMLRenderPage") as! HTMLRenderPageViewController
//        newViewController.privacyPolicy = false
//        newViewController.modalPresentationStyle = .fullScreen
//        self.present(newViewController, animated: false, completion: nil)
