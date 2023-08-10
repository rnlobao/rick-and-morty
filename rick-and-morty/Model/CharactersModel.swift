//
//  CharactersModel.swift
//  rick-and-morty
//
//  Created by Robson Novato on 09/08/23.
//

import Foundation

// MARK: - All Info
struct Characters: Codable {
    let info: CharactersInfo
    let results: [CharactersResult]
}

// MARK: - Info
struct CharactersInfo: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct CharactersResult: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: Species
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

struct Location: Codable {
    let name: String
    let url: String
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
