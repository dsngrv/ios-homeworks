//
//  SavedPostsCoordinator.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 18.01.2024.
//

import Foundation
import UIKit

final class SavedPostsCoordinator {
    
    func presentSavedPosts(navigationController: UINavigationController? , title: String) {
        let postViewController = SavedPostsViewController(coordinator: self)
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
}
