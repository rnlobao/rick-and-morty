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

final class MainViewModel {
    
    // MARK: - Properties
    var characters: [CharactersResult] = []
    var delegate: RickAndMortyDelegate?
    private var apiInfo: CharactersInfo? = nil
    
    public var shouldShowLoadBottom: Bool {
        return apiInfo?.next != nil
    }
    
    // MARK: - Initializers
    
    init(delegate: RickAndMortyDelegate? = nil) {
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    
    public func numberOfRowsInSection() -> Int {
        return characters.count
    }
    
    public func getData(pagination: Bool = false) {
        delegate?.showLoad()
        NetworkService.getCharacterData(pagination: pagination) { result in
            switch result {
            case .success(let data):
                self.characters.append(contentsOf: data.results)
                self.delegate?.getDataSucess()
                self.apiInfo = data.info
            case .failure(let error):
                self.delegate?.getDataFail(error: error)
            }
            self.delegate?.removeLoad()
        }
    }
}
