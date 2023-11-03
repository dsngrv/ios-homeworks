//
//  LoginFactory.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 22.09.2023.
//

import Foundation

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

class MainFactory: LoginFactory {
    
    private let inspector = LoginInspector()
    
    func makeLoginInspector() -> LoginInspector {
        return inspector
    }
    
}
