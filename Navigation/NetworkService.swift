//
//  NetworkService.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 08.12.2023.
//

import Foundation

struct People: Codable {
    let name: String
    let height: String
    let mass: String
}

struct Starships: Codable {
    let name: String
    let model: String
    let passengers: String
}

struct Planets: Codable {
    let name: String
    let climate: String
    let terrain: String
}

enum AppConfiguration: String, CaseIterable {
    private var baseURL: String { return "https://swapi.dev/api" }

    case people = "/people/3"
    case starships = "/starships/5"
    case planets = "/planets/7"
    
    var url: URL {
        guard let url = URL(string: baseURL) else {
            preconditionFailure("The url used in \(AppConfiguration.self) is not valid")
        }
        return url.appendingPathComponent(self.rawValue)
    }
}

struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        
        let url = configuration.url
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) {data, response, error in

            if let error {
                print("Error: \(error.localizedDescription)")
                //Ошибка при выключенном интернете:
                //Error: The Internet connection appears to be offline.
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("Status: \(httpResponse.statusCode)")
                print("\nHeaders: \(httpResponse.allHeaderFields)")
            }

            guard let data else {
                print("Empty data")
                return
            }
            do {
                switch configuration {
                case .people:
                    let people = try JSONDecoder().decode(People.self, from: data)
                    print("\nName: \(people.name) \nHeight: \(people.height) \nMass: \(people.mass)")
                case .starships:
                    let starship = try JSONDecoder().decode(Starships.self, from: data)
                    print("\nName: \(starship.name) \nModel: \(starship.model) \nPassengers: \(starship.passengers)")
                case .planets:
                    let planet = try JSONDecoder().decode(Planets.self, from: data)
                    print("\nName: \(planet.name) \nClimate: \(planet.climate) \nTerrain: \(planet.terrain)")
                }
            } catch {
                print("JSON processing error: \(error.localizedDescription)")

            }
        }
        dataTask.resume()
        
    }
    
}
