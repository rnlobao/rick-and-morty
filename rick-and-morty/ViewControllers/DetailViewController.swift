//
//  DetailViewController.swift
//  rick-and-morty
//
//  Created by Robson Novato on 10/08/23.
//

import Foundation
import UIKit


final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: CharactersResult
    
    // MARK: - UI Elements
    
    
    
    // MARK: - Initializers
    
    init(viewModel: CharactersResult) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.name
        view.backgroundColor = .white
    }
    
    
    
}
