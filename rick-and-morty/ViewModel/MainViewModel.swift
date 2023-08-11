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
    var apiInfo: CharactersInfo? = nil
    
    public var shouldLoadMoreInfo: Bool {
        return apiInfo?.next != nil
    }
    public var isLoadingMoreCharacters = false
     
    // MARK: - Initializers
    
    init(delegate: RickAndMortyDelegate? = nil) {
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    
    public func numberOfRowsInSection() -> Int {
        return characters.count
    }
    
    public func getData() {
        delegate?.showLoad()
        NetworkService.getCharacterData() { [weak self] result in
            guard let self = self else { return }
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
    
    public func getAdditionalData(urlString: String) {
        isLoadingMoreCharacters = true
        NetworkService.getDataFromURLGiven(url: urlString) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.characters.append(contentsOf: data.results)
                self.delegate?.getDataSucess()
                self.apiInfo = data.info
                isLoadingMoreCharacters = false
            case .failure(let error):
                self.delegate?.getDataFail(error: error)
            }
        }
    }
}
