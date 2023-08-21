//
//  User.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 16.08.2023.
//

import Foundation
import UIKit

class User {
    
    var login: String
    var fullName: String
    var status: String
    var avatar: UIImage
    
    
    init(login: String, fullName: String, status: String, avatar: UIImage) {
        self.login = login
        self.fullName = fullName
        self.status = status
        self.avatar = avatar
    }
    
}

protocol UserService {
    func logIn(login: String) -> User?
}

class CurrentUserService: UserService {
        
    var user: User?
    
    init(login: String) {
        self.user = logIn(login: login)
    }
    
    func logIn(login: String) -> User? {
        login == "doge" ? User(login: "doge", fullName: "Doge Coinov", status: "Hey!", avatar: UIImage(named: "doge") ?? UIImage()) : nil
    }

}

class TestUserService: UserService {
    
    var user: User? = User(login: "testmode", fullName: "Test User", status: "TEST!", avatar: UIImage(named: "doge_bnw") ?? UIImage())
    
    init(login: String) {
        self.user = logIn(login: login)
    }
    
    func logIn(login: String) -> User? {
        login == user?.login ? self.user : nil
    }
    
}
