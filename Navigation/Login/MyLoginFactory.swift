//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 22.09.2023.
//

import Foundation

struct MyLoginFactory: LoginFactory {
    
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}
