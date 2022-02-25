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
//        performSegue(withIdentifier: "loginToHomeScreenSegue", sender: self)
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
               var message: String = ""
               if (success) {
                   self.loaderView.isHidden = true
                   let homeViewController = self.storyboard?.instantiateViewController(identifier: "HomeVC") as? HomeViewController
                   
                   self.view.window?.rootViewController = homeViewController
                   self.view.window?.makeKeyAndVisible()
                   
               } else {
                   self.loaderView.isHidden = true
                   message = msg
                   let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                   alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                   self.present(alertController, animated: true, completion: nil)
               }
              

           }
        
    }
    
    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        print("SignUp Tapped")
        performSegue(withIdentifier: "registerSegue", sender: self)
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

extension String {
    func isValidEmail() -> Bool {
        let emailReg: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
               let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailReg)
        return emailTest.evaluate(with: self)
        
    }
    
    var isInt: Bool {
          return Int(self) != nil
      }
}
