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
    @IBOutlet weak var profileErrorText: UILabel!
    
    @IBOutlet weak var loaderView: UIView!
    
    var registerVM: RegisterViewModel?
    
    var imagePicker = UIImagePickerController()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerVM = RegisterViewModel()
        imagePicker.delegate = self
        loaderView.isHidden = true
        
        customizeImageView()
        setUpUI()
    }

    @IBAction func didTapRegisterButton(_ sender: UIButton) {
        print("Register tapped")
       
        setUpUI()
        guard let dp = imageView.image, let firstName = firstNameTextField.text , let lastName = lastNameTextField.text,let age = ageTextField.text,let emailAddress = emailTextField.text, let password = passwordTextField.text else {
                return
            }
        
        if(dp == Constants.Image.personImage){
            profileErrorText.isHidden = false
            return
        }

        loaderView.isHidden = false
        registerVM?.registerUser(photo:dp.jpegData(compressionQuality: 0.1) ,firstName: firstName, lastName: lastName, age: age , email: emailAddress, password: password) {[weak self] (success, msg) in
            guard let `self` = self else { return }
            if (success) {
                self.loaderView.isHidden = true
                self.presentAlertWithTitle(title: nil, message: Constants.CustomStrings.userCreationSucces, options: Constants.AlertOptions.okButton) { (option) in
                           print("option: \(option)")
                           switch(option) {
                               case Constants.AlertOptions.okButton:
                               AppNavigationHandler.goToHomeScreen(currentController: self)
                                   break
                               default:
                                   break
                           }
                       }

            } else {
                
                self.loaderView.isHidden = true
                
                switch (msg) {
                    
                    
                case Constants.ErrorText.nameError:
                    self.firstNameErrorText.text = Constants.ErrorText.nameError
                    self.firstNameErrorText.isHidden = false
                    break
                    
                case Constants.ErrorText.ageError:
                    self.ageErrorText.text = Constants.ErrorText.ageError
                    self.ageErrorText.isHidden = false
                    break
                   case Constants.ErrorText.emailError:
                        self.emailErrorText.text = Constants.ErrorText.emailError
                        self.emailErrorText.isHidden = false
                        break
                    
                case Constants.ErrorText.passwordError:
                        self.passwordErrorText.text = Constants.ErrorText.passwordError
                        self.passwordErrorText.isHidden = false
                        break
                default:
                    
                    self.presentAlertWithTitle(title: nil, message: Constants.CustomStrings.userCreationfail, options: Constants.AlertOptions.okButton) { (option) in
                               print("option: \(option)")
                               switch(option) {
                                   case Constants.AlertOptions.okButton:
                                       break
                                   default:
                                       break
                               }
                           }
                }
            }
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
        profileErrorText.isHidden = true
        firstNameErrorText.isHidden = true
        ageErrorText.isHidden = true
        emailErrorText.isHidden = true
        passwordErrorText.isHidden = true
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        ageTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    func backToLoginPage() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // customize image view
    func customizeImageView(){
        
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
}

// MARK: - Image picker

extension RegisterViewController: UIImagePickerControllerDelegate ,  UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        imageView.image = image
        dismiss(animated: true)
    }
}
