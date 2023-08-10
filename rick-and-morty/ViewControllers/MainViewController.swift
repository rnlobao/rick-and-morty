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
        self.title = "Characters"
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
    
    // MARK: - Private Properties
    
    private func showDetailScreen(viewModel: CharactersResult) {
        navigationController?.pushViewController(DetailViewController(viewModel: viewModel), animated: true)
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
}

// MARK: - TableView Protocols
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if viewModel.shouldShowLoadBottom {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: FooterLoadingTableViewCell.identifier, for: indexPath) as? FooterLoadingTableViewCell else { return UITableViewCell() }
//            cell.selectionStyle = .none
//            return cell
//        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RickAndMortyTableViewCell.identifier, for: indexPath) as? RickAndMortyTableViewCell else { return UITableViewCell() }
        let currentCharacter = viewModel.characters[indexPath.row]
        cell.configure(title: currentCharacter.name, description: currentCharacter.status.rawValue, image: currentCharacter.image)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currentCharacter = viewModel.characters[indexPath.row]
        showDetailScreen(viewModel: currentCharacter)
    }
    
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (mainTableView.contentSize.height-100-scrollView.frame.size.height) {
            self.mainTableView.tableFooterView = createSpinnerFooter()
            
            
        }
    }
}


// MARK: - Screen State Delegate
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

