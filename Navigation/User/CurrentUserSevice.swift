//
//  CurrentUserSevice.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 20.09.2023.
//

import Foundation
import UIKit

final class CurrentUserService: UserService {

    let user = User(fullName: "Doge Coinov", status: "To the moon...", avatar: UIImage(named: "doge") ?? UIImage())

    func getUser() -> User { user }
    
}
