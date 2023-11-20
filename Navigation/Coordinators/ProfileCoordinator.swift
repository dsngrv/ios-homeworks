//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 31.10.2023.
//

import Foundation
import UIKit

final class ProfileCoordinator {
    
    func presentProfile(navigationController: UINavigationController?, user: User?){
        let profileViewController = ProfileViewController(currentUser: user, coordinator: self)
        navigationController?.pushViewController(profileViewController, animated: true)
    }
   
    func presentPhoto(navigationController: UINavigationController?){
        let photoViewController = PhotosViewController()
        navigationController?.pushViewController(photoViewController, animated: true)
    }

}
