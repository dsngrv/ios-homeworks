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
