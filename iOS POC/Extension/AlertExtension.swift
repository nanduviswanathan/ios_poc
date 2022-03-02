//
//  AlertExtension.swift
//  iOS POC
//
//  Created by NanduV on 01/03/22.
//

import Foundation
import UIKit

extension UIViewController {

    func presentAlertWithTitle(title: String?, message: String, options: String..., completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(options[index])
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}




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
