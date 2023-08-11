//
//  rick_and_mortyTests.swift
//  rick-and-mortyTests
//
//  Created by Robson Novato on 09/08/23.
//

import XCTest
@testable import rick_and_morty

final class rick_and_mortyTests: XCTestCase {
    
    var viewModel: MainViewModel!
    let mockedService = NetworkServiceMock()

    override func setUp() {
        super.setUp()
        viewModel = MainViewModel(service: mockedService)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testNumberOfRowsInSection() {
        let char = CharactersResult(id: 1, name: "", status: .alive, species: "", type: "", gender: .female, origin: Location(name: "", url: ""), location: Location(name: "", url: ""), image: "", episode: [""], url: "", created: "")
        viewModel.characters = [char]
        XCTAssertEqual(viewModel.numberOfRowsInSection(), 1)
    }
    
    func testGetDataSuccess() {
        viewModel.getData()
        XCTAssertEqual(viewModel.characters.count, 4)
    }
    
    func testGetAdditionalData() {
        viewModel.getAdditionalData(urlString: "")
        XCTAssertEqual(viewModel.characters.count, 4)
    }

}
