//
//  ViewController.swift
//  rick-and-morty
//
//  Created by Robson Novato on 09/08/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: MainViewModel!
    
    // MARK: - UI Elements
    
    private lazy var mainTableView: UITableView = {
       let tableView = UITableView()
        tableView.allowsSelection = true
        
        tableView.register(RickAndMortyTableViewCell.self, forCellReuseIdentifier: RickAndMortyTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel(delegate: self)
        self.title = "Rick And Morty"
        setupUI()
        setupConstraints()
        viewModel.getData()
    }

    // MARK: - Setup UI
    
    private func setupUI() {
        self.view.addSubview(mainTableView)
    }
    
    private func setupConstraints() {
        mainTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - TableView Protocols
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RickAndMortyTableViewCell.identifier, for: indexPath) as? RickAndMortyTableViewCell else { return UITableViewCell() }
        let currentCharacter = viewModel.characters[indexPath.row]
        cell.configure(title: currentCharacter.name, description: currentCharacter.type, image: currentCharacter.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension MainViewController: RickAndMortyDelegate {
    func getDataSucess() {
        mainTableView.reloadData()
    }
    
    func getDataFail(error: Error) {
        let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showLoad() {
        showSpinner(onView: view)
    }
    
    func removeLoad() {
        removeSpinner()
    }
    
    
}
