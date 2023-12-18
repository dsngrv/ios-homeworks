//
//  NetworkManager.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 13.12.2023.
//

import Foundation

final class NetworkManager {
    
    static func requestTitle(for configuration: AppConfiguration, completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        guard let url = configuration.url else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) {data, response, error in
            
            if let error {
                print("Ошибка: \(error.localizedDescription)")
                completion(.failure(.unowned))
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    if let data = data {
                        do {
                            guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                            guard let title = jsonDictionary["title"] as? String else { return }
                            completion(.success(title))
                        } catch {
                            print("Ошибка обработки JSON: \(error.localizedDescription)")
                            completion(.failure(.decodeError))
                        }
                    }
                case 404:
                    completion(.failure(.notFound))
                default:
                    break
                }
            }
        }
        dataTask.resume()
    }
    
    static func decode<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.unowned))
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    if let data = data {
                        let decoder = JSONDecoder()
                        do {
                            let value = try decoder.decode(T.self, from: data)
                            completion(.success(value))
                        } catch {
                            completion(.failure(.decodeError))
                        }
                    }
                case 404:
                    completion(.failure(.notFound))
                case 500:
                    completion(.failure(.serverError))
                default:
                    assertionFailure("Unowned error: \(response.statusCode)")
                    completion(.failure(.unowned))
                }
            }
        }
        dataTask.resume()
    }
    
}
