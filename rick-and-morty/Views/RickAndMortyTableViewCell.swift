//
//  RickAndMortyTableViewCell.swift
//  rick-and-morty
//
//  Created by Robson Novato on 09/08/23.
//

import UIKit
import SnapKit

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
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Error"
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var containerView: UIView = UIView()
    
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
        descriptionLabel.text = description
    }
    
    // MARK: - Private Methods
    
//    private func convertStringToImage(myString: String) -> UIImage {
//        
//        
//    }
    
    // MARK: - Setup UI

    private func setupUI() {
        self.contentView.addSubview(containerView)
        containerView.addSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(cellImageView)
        horizontalStackView.addArrangedSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)

        }
        
        horizontalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        verticalStackView.snp.makeConstraints {
            $0.width.equalTo(cellImageView.snp.width).multipliedBy(2)
        }
        
        cellImageView.snp.makeConstraints {
            $0.width.equalTo(300)
        }
    }
    
}
