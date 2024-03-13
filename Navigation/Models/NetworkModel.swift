//
//  NetworkModel.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 13.12.2023.
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

struct Planets: Decodable {
    let name: String
    let orbitalPeriod: String
    let climate, terrain: String

    enum CodingKeys: String, CodingKey {
        case name
        case orbitalPeriod = "orbital_period"
        case climate, terrain
    }
}

enum AppConfiguration: String, CaseIterable {
    case randomTitle = "https://jsonplaceholder.typicode.com/todos/56"
    case people = "https://swapi.dev/api/people/3"
    case starships = "https://swapi.dev/api/starships/5"
    case planets = "https://swapi.dev/api/planets/1"
    
    var url: URL? {
        URL(string: self.rawValue)
    }
}

enum NetworkError: Int, Error {
    case badRequest = 400
    case unauthorized = 401
    case notFound = 404
    case decodeError = 1000
    case serverError = 500
    case unowned = 2000
}
