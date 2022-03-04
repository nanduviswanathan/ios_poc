//
//  StringExtension.swift
//  iOS POC
//
//  Created by NanduV on 01/03/22.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailReg: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailReg)
        print("swlf--------\(self)")
        return emailTest.evaluate(with: self)
        
    }
    
    var isInt: Bool {
          return Int(self) != nil
      }
    
    func isValidPassword() -> Bool {
        print("-------\(self.count >= 6)")
        return self.count >= 6
    }
}
