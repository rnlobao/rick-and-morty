//
//  DetailViewController.swift
//  rick-and-morty
//
//  Created by Robson Novato on 10/08/23.
//

import Foundation
import UIKit
import Nuke
import SnapKit

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: CharactersResult
    
    // MARK: - UI Elements
    
    private lazy var verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private lazy var characterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "questionmark")
        return imageView
    }()
    
    private lazy var statusLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "Error"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var speciesLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "Error"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "Error"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var genderLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "Error"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var originLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "Error"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "Error"
        label.numberOfLines = 0
        return label
    }()
    
    
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
        
        setupUI()
        configure()
        setupConstraints()
    }
    
    // MARK: - Public Methods
    
    public func configure() {
        statusLabel.text = "Status: \(viewModel.status.rawValue)"
        speciesLabel.text = "Species: \(viewModel.species)"
        typeLabel.text = "Type: \(viewModel.type)"
        genderLabel.text = "Gender: \(viewModel.gender.rawValue)"
        originLabel.text = "Origin: \(viewModel.origin.name)"
        locationLabel.text = "Location: \(viewModel.location.name)"
        
        if let url = URL(string: viewModel.image) {
            Nuke.loadImage(with: ImageRequest(url: url), into: characterImageView)
        }
    }
    
    
    // MARK: - Setup UI
    
    private func setupUI() {
        self.view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(characterImageView)
        verticalStackView.addArrangedSubview(statusLabel)
        verticalStackView.addArrangedSubview(speciesLabel)
        if !viewModel.type.isEmpty {
            verticalStackView.addArrangedSubview(typeLabel)
        }
        verticalStackView.addArrangedSubview(genderLabel)
        verticalStackView.addArrangedSubview(originLabel)
        verticalStackView.addArrangedSubview(locationLabel)
    }
    
    private func setupConstraints() {
        
        verticalStackView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        characterImageView.snp.makeConstraints {
            $0.height.equalTo(characterImageView.snp.width)
        }
    }
}
