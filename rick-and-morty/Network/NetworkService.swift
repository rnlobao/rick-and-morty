//
//  NetworkService.swift
//  rick-and-morty
//
//  Created by Robson Novato on 09/08/23.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

protocol NetworkServicing {
    func getCharacterData(completionHandler: @escaping (_ result: Result<Characters, NetworkError>) -> Void)
    func getDataFromURLGiven(url: String, completionHandler: @escaping (_ result: Result<Characters, NetworkError>) -> Void)
}

public class NetworkService: NetworkServicing {
    func getCharacterData(completionHandler: @escaping (_ result: Result<Characters, NetworkError>) -> Void) {
        guard let urlString = URL(string: NetworkConstants.shared.geralUrl) else { return }

        AF.request(urlString).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let userResponse = try JSONDecoder().decode(AllUrls.self, from: data!)
                    self.getDataFromURLGiven(url: userResponse.characters) { result in
                        completionHandler(result)
                    }
                    
                } catch {
                    completionHandler(.failure(.canNotParseData))
                }
                
            case .failure(_):
                completionHandler(.failure(.canNotParseData))
            }
        }
    }
    
    func getDataFromURLGiven(url: String, completionHandler: @escaping (_ result: Result<Characters, NetworkError>) -> Void) {
        guard let urlString = URL(string: url) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        AF.request(urlString).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let userResponse = try JSONDecoder().decode(Characters.self, from: data!)
                    completionHandler(.success(userResponse))
                    
                } catch {
                    completionHandler(.failure(.canNotParseData))
                }
                
            case .failure(_):
                completionHandler(.failure(.canNotParseData))
            }
        }
    }
}

public class NetworkServiceMock: NetworkServicing {
    private func generate4Characters() -> Characters {
        let defaultLocation = Location(name: "Earth", url: "")
        let response = Characters(info: CharactersInfo(count: 0, pages: 0, next: "", prev: ""), results: [
            CharactersResult(id: 1, name: "Rick", status: .alive, species: "Human", type: "", gender: .female, origin: defaultLocation, location: defaultLocation, image: "", episode: [""], url: "", created: ""),
            CharactersResult(id: 1, name: "Alice", status: .alive, species: "Alien", type: "", gender: .female, origin: defaultLocation, location: defaultLocation, image: "", episode: ["Episode 1", "Episode 2"], url: "", created: "2023-08-11"),
            CharactersResult(id: 2, name: "Max", status: .dead, species: "Mutant", type: "", gender: .male, origin: defaultLocation, location: defaultLocation, image: "", episode: ["Episode 3", "Episode 4"], url: "", created: "2023-08-10"),
            CharactersResult(id: 3, name: "Zoe", status: .unknown, species: "Human", type: "", gender: .unknown, origin: Location(name: "Futuristic City", url: ""), location: Location(name: "Futuristic City", url: ""), image: "", episode: ["Episode 5", "Episode 6"], url: "", created: "2023-08-09")
        ])
        return response
    }
    
    func getCharacterData(completionHandler: @escaping (Result<Characters, NetworkError>) -> Void) {
        completionHandler(.success(generate4Characters()))
    }
    
    func getDataFromURLGiven(url: String, completionHandler: @escaping (Result<Characters, NetworkError>) -> Void) {
        completionHandler(.success(generate4Characters()))
    }
    
    
}
