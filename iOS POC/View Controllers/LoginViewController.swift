//
//  ViewController.swift
//  iOS POC
//
//  Created by NanduV on 18/02/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailErrorText: UILabel!
    
    @IBOutlet weak var passwordErrorText: UILabel!
    
    @IBOutlet weak var loaderView: UIView!
    
    var authVM: AuthViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        clearErrorText()
        authVM = AuthViewModel()
            
        passwordTextField.textContentType = .oneTimeCode
        loaderView.isHidden = true
        
        closeKeyboardOnReturn()
        print("App started");
//        emailTextField.addTarget(self, action: #selector(checkAndDisplayEmailError(emailTextField:)), for: .editingChanged)
//        passwordTextField.addTarget(self, action: #selector(checkAndDisplayPasswordError(passwordTextField:)), for: .editingChanged)
    }

    @IBAction func didTapContinueButton(_ sender: UIButton) {
        print("Continue tapped")
        clearErrorText()
        guard let emailAddress = emailTextField.text, let password = passwordTextField.text else {
                return
            }
        self.loaderView.isHidden = false
           authVM?.logIn(email: emailAddress, pass: password) {[weak self] (success,msg) in
               guard let `self` = self else { return }
               self.loaderView.isHidden = true
               if (success) {
                   AppNavigationHandler.goToHomeScreen(currentController: self)
                   
               } else {
                   
                   
                switch (msg) {
                   case Constants.ErrorText.emailError:
                        self.emailErrorText.text = Constants.ErrorText.emailError
                        self.emailErrorText.isHidden = false
                        break
                    
                case Constants.ErrorText.passwordError:
                        self.passwordErrorText.text = Constants.ErrorText.passwordError
                        self.passwordErrorText.isHidden = false
                        break
                       
                default:
                        self.presentAlertWithTitle(title: nil, message: msg, options: Constants.AlertOptions.okButton) { (option) in
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
    
    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        print("SignUp Tapped")
        AppNavigationHandler.goToRegisterScreen(currentController: self)
    }
    
    
    func clearErrorText(){
        passwordErrorText.isHidden = true
        emailErrorText.isHidden = true
    }
    
    func closeKeyboardOnReturn(){
        Utilities.returnKeyFunc(emailTextField)
        Utilities.returnKeyFunc(passwordTextField)
    }
}
