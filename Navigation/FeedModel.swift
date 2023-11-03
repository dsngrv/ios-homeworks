//
//  FeedModel.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 11.10.2023.
//

import Foundation

class FeedModel {
    
    private var secretWord: String = "Пароль"
        
    func check(word: String) -> Bool {
        self.secretWord == word
    }
    
}
