//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 01.06.2023.
//

import Foundation
import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    private var processingTimer = 0.0
        
    private lazy var photosArray: [UIImage] = []
    private lazy var photos = Photo.makePhotosCollection()
    private lazy var imagePublisherFacade = ImagePublisherFacade()
    
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
        navigationItem.title = NSLocalizedString("photoGallery", comment: "")
        navigationController?.navigationBar.isHidden = false
        layout()
        processingTimer = CFAbsoluteTimeGetCurrent()
        /* 
        background = 3.39
        default = 1.16
        userInitiated = 1.08
        userInteractive = 1.00
        utility = 1.71 
         */
        ImageProcessor().processImagesOnThread(sourceImages: photos,
                                               filter: .fade,
                                               qos: .default) { photos in
            self.processingTimer = CFAbsoluteTimeGetCurrent() - self.processingTimer
            print("Обработка заняла \(self.processingTimer) скунд")
            for image in photos {
                self.photosArray.append(UIImage(cgImage: image!))
            }
            DispatchQueue.main.async {
                self.imageCollection.reloadData()
            }
        }
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
        photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell()}
        cell.setupCollectionCell(photosArray[indexPath.item])
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
