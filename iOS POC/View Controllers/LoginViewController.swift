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
        if (emailAddress.isEmpty || !emailAddress.isValidEmail() ) {
                emailErrorText.isHidden = false
                return
            }
            if (password.isEmpty) {
                passwordErrorText.isHidden = false
                return
            }
        
        print("wanna continue")
        self.loaderView.isHidden = false
           authVM?.logIn(email: emailAddress, pass: password) {[weak self] (success,msg) in
               guard let `self` = self else { return }
               self.loaderView.isHidden = true
               if (success) {
                
//                   let storyBoard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.storyBoardName, bundle: nil)
//                   let newViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as UIViewController
//                           newViewController.modalPresentationStyle = .fullScreen
//                           self.present(newViewController, animated: false, completion: nil)
                   AppNavigationHandler.goToHomeScreen(currentController: self)
                   
               } else {
//                   self.loaderView.isHidden = true
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
    
    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        print("SignUp Tapped")
//        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.storyBoardName, bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Storyboard.registerViewController) as UIViewController
//                newViewController.modalPresentationStyle = .fullScreen
//                self.present(newViewController, animated: false, completion: nil)
        AppNavigationHandler.goToRegisterScreen(currentController: self)
    }
    
    
    
    
    func clearErrorText(){
        passwordErrorText.isHidden = true
        emailErrorText.isHidden = true
    }
    
    
//    @objc func checkAndDisplayEmailError (emailTextField: UITextField ) {
//        let emailReg: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
//        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailReg)
//
//        if emailTest.evaluate(with: emailTextField.text!) == false {
//            emailErrorText.isHidden = false
//            emailErrorText.text = "Please enter valid email address"
//
//        } else {
//            emailErrorText.text = ""
//            emailErrorText.isHidden = true
//        }
//    }
//
//
//    @objc func checkAndDisplayPasswordError (passwordTextField: UITextField ) {
//
//
//        if (passwordTextField.text?.count ?? 0 < 1 ) {
//           passwordErrorText.isHidden = false
//        passwordErrorText.text = "Please enter valid password"
//
//        } else {
//            emailErrorText.text = ""
//            emailErrorText.isHidden = true
//        }
//    }

}





//if UserDefaults.standard.string(forKey: "token") != nil{
//            navigateToHomeADS()
//        }else if UserDefaults.standard.bool(forKey: "introWalkThroughShown") == false{
//            navigateToIntro()
//        }else{
//            navigateToLogin()
//        }
