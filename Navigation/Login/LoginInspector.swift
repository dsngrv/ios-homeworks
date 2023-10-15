//
//  LoginInspector.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 19.09.2023.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    
    func check(login: String, password: String) -> Bool {
        Checker.shared.check(login: login, password: password)
    }
}
