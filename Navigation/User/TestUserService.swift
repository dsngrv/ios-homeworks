//
//  TestUserService.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 20.09.2023.
//

import Foundation
import UIKit

final class TestUserService: UserService {

    private let user = User(fullName: "test mode", status: "test", avatar: UIImage(named: "doge_bnw") ?? UIImage())

    func getUser() -> User { user }
    
}
