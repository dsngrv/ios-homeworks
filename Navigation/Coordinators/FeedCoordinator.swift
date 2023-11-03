//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 31.10.2023.
//

import Foundation
import UIKit

final class FeedCoordinator {
    
    func presentPost(navigationController: UINavigationController? , title: String) {
        let postViewController = PostViewController(postTitle: title, coordinator: self)
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    func presentInfo(navigationController: UINavigationController?){
        let infoViewController = InfoViewController()
        infoViewController.modalTransitionStyle = .coverVertical
        infoViewController.modalPresentationStyle = .pageSheet
        navigationController?.present(infoViewController, animated: true)
    }
    
}
