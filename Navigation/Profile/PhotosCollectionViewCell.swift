//
//  PhotoCollectionViewCell.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 01.06.2023.
//

import Foundation
import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageCollectionCell: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionCell(_ photo: UIImage) {
        imageCollectionCell.image = photo
    }
    
    private func layout() {
        
        contentView.addSubview(imageCollectionCell)
        
        NSLayoutConstraint.activate([
            imageCollectionCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCollectionCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCollectionCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageCollectionCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
