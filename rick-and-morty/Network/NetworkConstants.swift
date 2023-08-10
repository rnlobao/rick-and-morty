//
//  NetworkConstants.swift
//  rick-and-morty
//
//  Created by Robson Novato on 09/08/23.
//

import Foundation

class NetworkConstants {
    public static var shared: NetworkConstants = NetworkConstants()
    
    private init() {
    }
    
    public var geralUrl: String = "https://rickandmortyapi.com/api"
}
