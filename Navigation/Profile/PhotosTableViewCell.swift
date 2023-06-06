//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 01.06.2023.
//

import Foundation
import UIKit

protocol PhotosGalleryDelegate: AnyObject {
    func openGallery()
}

class PhotosTableViewCell: UITableViewCell {
    
    weak var delegate: PhotosGalleryDelegate?
    
    private let photoCollection = Photo.makePhotoCollection()
    
    private lazy var collectionPhotoView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var collectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Photos"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var openGalleryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var imageCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let imageCollection = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        imageCollection.delegate = self
        imageCollection.dataSource = self
        imageCollection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return imageCollection
    }()
    
    @objc private func tapButton() {
        self.delegate?.openGallery()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { 
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
        [collectionLabel, openGalleryButton, imageCollection].forEach{contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            collectionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            collectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            collectionLabel.bottomAnchor.constraint(equalTo: imageCollection.topAnchor, constant: -12),
            
            openGalleryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            openGalleryButton.centerYAnchor.constraint(equalTo: collectionLabel.centerYAnchor),
            openGalleryButton.heightAnchor.constraint(equalToConstant: 20),
            openGalleryButton.widthAnchor.constraint(equalToConstant: 20),
            
            imageCollection.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor, constant: 12),
            imageCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            imageCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            imageCollection.heightAnchor.constraint(equalToConstant: 100),
            imageCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
            
        ])
    }
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat {return 8}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * 5) / 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }

}


extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else {return UICollectionViewCell()}
        cell.setupCollectionCell(photoCollection[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoCollection.count
    }
    
}
