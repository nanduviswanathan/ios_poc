//
//  AlertExtension.swift
//  iOS POC
//
//  Created by NanduV on 01/03/22.
//

import Foundation
import UIKit

extension UIViewController:UITextFieldDelegate {
    
    // show alert
    func presentAlertWithTitle(title: String?, message: String, options: String..., completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(options[index])
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    // show toast
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
      textField.resignFirstResponder()
        return true
    }
}
    
//    extension UIViewController:UITextFieldDelegate {
//
//        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
//          textField.resignFirstResponder()
//            return true
//
//        }
//
//    }

//presentAlertWithTitle(title: "Test", message: "A sample message", options: "start", "stop", "cancel") { (option) in
//           print("option: \(option)")
//           switch(option) {
//               case "start":
//                   print("start button pressed")
//                   break
//               case "stop":
//                   print("stop button pressed")
//                   break
//               case "cancel":
//                   print("cancel button pressed")
//                   break
//               default:
//                   break
//           }
//       }

//            showToast(message: "sample is herbdkfhagsdfgadsjfghdsafgldsfdsf", font: .systemFont(ofSize: 12.0))
