//
//  RickAndMortyTableViewCell.swift
//  rick-and-morty
//
//  Created by Robson Novato on 09/08/23.
//

import UIKit
import SnapKit
import Nuke

class RickAndMortyTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = String(describing: RickAndMortyTableViewCell.self)
    
    
    // MARK: - UI Elements
    private lazy var cellImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "questionmark")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Error"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "Error"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customGray
        view.layer.cornerRadius = 8
        return view
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func configure(title: String, description: String, image: String) {
        titleLabel.text = title
        descriptionLabel.text = "Status: \(description)"
        if let url = URL(string: image) {
            Nuke.loadImage(with: ImageRequest(url: url), into: cellImageView)
        }
    }
    
    // MARK: - Setup UI

    private func setupUI() {
        self.contentView.addSubview(containerView)
        containerView.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(cellImageView)
        verticalStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)

        }
        
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        cellImageView.snp.makeConstraints {
            $0.width.height.equalTo(300)
        }
    }
    
}
