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

public class NetworkService {
    static func getCharacterData(pagination: Bool = false, completionHandler: @escaping (_ result: Result<Characters, NetworkError>) -> Void) {
        guard let urlString = URL(string: NetworkConstants.shared.geralUrl) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        AF.request(urlString).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let userResponse = try JSONDecoder().decode(AllUrls.self, from: data!)
                    getDataFromURLGiven(url: userResponse.characters) { result in
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
    
    static private func getDataFromURLGiven(url: String, completionHandler: @escaping (_ result: Result<Characters, NetworkError>) -> Void) {
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
