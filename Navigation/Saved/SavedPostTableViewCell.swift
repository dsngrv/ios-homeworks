//
//  SavedPostTableViewCell.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 18.01.2024.
//

import Foundation
import StorageService
import UIKit

final class SavedPostTableViewCell: UITableViewCell {
    
    private lazy var postHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()
    
    private lazy var postDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ post: SavedPost) {
        postHeaderLabel.text = post.author
        postImage.image = UIImage(named: post.image ?? " ")
        postDescription.text = post.descr
    }
    
    private func setupLayout() {
        [postHeaderLabel, postImage, postDescription].forEach({contentView.addSubview($0)})

        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        NSLayoutConstraint.activate([
            postHeaderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            postHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postImage.topAnchor.constraint(equalTo: postHeaderLabel.bottomAnchor, constant: 12),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: screenWidth),
            postImage.widthAnchor.constraint(equalToConstant: screenWidth),
            
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            postDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
