//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 24.10.2023.
//

import Foundation

protocol FeedViewModelProtocol {
    func check(word: String) -> Bool
}

final class FeedViewModel: FeedViewModelProtocol {
    
    private var wordModel = Words()
    private var secretWord: String
    
    init() {
        secretWord = wordModel.randomizeWords()
    }
    
    func check(word: String) -> Bool {
        self.secretWord == word
    }

}
