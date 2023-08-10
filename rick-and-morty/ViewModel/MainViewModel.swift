//
//  MainViewModel.swift
//  rick-and-morty
//
//  Created by Robson Novato on 09/08/23.
//

import Foundation

protocol RickAndMortyDelegate {
    func getDataSucess()
    func getDataFail(error: Error)
    func showLoad()
    func removeLoad()
}

class MainViewModel {
    
    // MARK: - Properties
    var characters: [CharactersResult] = []
    var delegate: RickAndMortyDelegate?
    
    init(delegate: RickAndMortyDelegate? = nil) {
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    
    public func numberOfRowsInSection() -> Int {
        return characters.count
    }
    
    public func getData() {
        NetworkService.getCharacterData { result in
            switch result {
            case .success(let data):
                self.characters = data.results
                self.delegate?.getDataSucess()
            case .failure(let error):
                self.delegate?.getDataFail(error: error)
            }
            self.delegate?.removeLoad()
        }
    }
}
