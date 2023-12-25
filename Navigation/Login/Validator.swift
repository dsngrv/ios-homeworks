//
//  Validator.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 25.12.2023.
//

import Foundation

extension String {
    
    func isValidMail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        
        return result
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[0-9].*[0-9]).{6,16}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        let result = passwordTest.evaluate(with: password)
        return result
    }
}
