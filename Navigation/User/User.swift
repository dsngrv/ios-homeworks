//
//  User.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 20.09.2023.
//

import Foundation
import UIKit

class User {
    
    var fullName: String
    var status: String
    var avatar: UIImage
    
    
    init(fullName: String, status: String, avatar: UIImage) {
        self.fullName = fullName
        self.status = status
        self.avatar = avatar
    }
    
}
