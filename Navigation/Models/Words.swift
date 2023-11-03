//
//  Words.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 31.10.2023.
//

import Foundation

struct Word {
    let word: String
}

final class Words {
    
    private let words = [
        Word(word: "Пароль"),
        Word(word: "Котик"),
        Word(word: "Doge")
    ]
    
    func randomizeWords() -> String {
        guard let randomWord = words.randomElement() else { return "error" }
        return randomWord.word
    }
}
