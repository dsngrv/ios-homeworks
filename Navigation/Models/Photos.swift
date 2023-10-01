//
//  Photos.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 01.06.2023.
//

import Foundation
import UIKit

struct Photo {
    
    let photo: UIImage?
    
    static func makePhotoCollection() -> [Photo] {
        var photoCollection: [Photo] = []
        for image in 0...19 {
            photoCollection.append(Photo(photo:UIImage(named: "\(image)")))
        }
        return photoCollection
    }
    
    static func makePhotosCollection() -> [UIImage] {
        var photoCollection: [UIImage] = []
        for image in 0...19 {
            photoCollection.append(UIImage(named: "\(image)")!)
        }
        return photoCollection
    }
    
}
