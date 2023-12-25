//
//  CheckerService.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 21.12.2023.
//

import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol {
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
}

class CheckerService: CheckerServiceProtocol {
    
    func checkCredentials(email: String, password: String, completion: @escaping ((Result<AuthDataResult, Error>) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if let error {
                completion(.failure(error))
                return
            }
            
            if let authResult = result {
                completion(.success(authResult))
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping ((Result<AuthDataResult, Error>) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if let error {
                completion(.failure(error))
            }
            
            if let authResult = result {
                completion(.success(authResult))
            }

        }
        
    }
    
}
