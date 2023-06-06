//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 01.06.2023.
//

import Foundation
import UIKit

class PhotosViewController: UIViewController {
    
    private lazy var photosCollection = Photo.makePhotoCollection()
    
    private lazy var imageCollection: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            
            let imageCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            imageCollection.translatesAutoresizingMaskIntoConstraints = false
            imageCollection.delegate = self
            imageCollection.dataSource = self
            imageCollection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
            return imageCollection
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            navigationItem.title = "Photos Gallery"
            navigationController?.navigationBar.isHidden = false
            layout()
        }
        
        private func layout() {
            view.addSubview(imageCollection)
            
            NSLayoutConstraint.activate([
                imageCollection.topAnchor.constraint(equalTo: view.topAnchor),
                imageCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                imageCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell()}
        cell.setupCollectionCell(photosCollection[indexPath.item])
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat {return 8}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (imageCollection.bounds.width - sideInset * 4) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
}
