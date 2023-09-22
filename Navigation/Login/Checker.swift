//
//  Checker.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 18.09.2023.
//

import Foundation

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}

final class Checker: LoginViewControllerDelegate {
    
    static let shared = Checker()
    
    private init() {}
    
    private let login = "login"
    private let password = "password"
    
    func check(login: String, password: String) -> Bool {
        self.login == login && self.password == password ? true : false
    }
}

