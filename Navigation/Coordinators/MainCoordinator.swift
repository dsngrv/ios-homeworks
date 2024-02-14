//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 31.10.2023.
//

import Foundation
import UIKit

final class MainCoordinator {
    
    private var tabBarController: UITabBarController
    
    init() {
        tabBarController = UITabBarController()
    }
        
    func startApp() -> UIViewController {
        setupTabBarController()
        return tabBarController
    }
        
    private func setupTabBarController(){
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = [createFeed(), createProfile(), createSavedPostsList()]
        tabBarController.selectedIndex = 1
    }
        
    private func createFeed() -> UINavigationController {
        let feedCoordinator = FeedCoordinator()
        let feedNavigationController = UINavigationController(rootViewController: FeedViewController(coordinator: feedCoordinator))
            feedNavigationController.title = NSLocalizedString("feed", comment: "")
            feedNavigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("feed", comment: ""), image: UIImage(systemName:"rectangle.3.group.bubble"), tag: 0)
        return feedNavigationController
    }

    private func createProfile() -> UINavigationController {
        let profileCoordinator = ProfileCoordinator()
        let loginFactory = MainFactory()
        let loginViewController = LogInViewContoller(coordinator: profileCoordinator)
        loginViewController.loginDelegate = loginFactory.makeLoginInspector()
        let profileNavigationController = UINavigationController(rootViewController: loginViewController)
        profileNavigationController.title = NSLocalizedString("profile", comment: "")
        profileNavigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("profile", comment: ""), image: UIImage(systemName: "person"), tag: 1)
        return profileNavigationController
        }
    
    private func createSavedPostsList() -> UINavigationController {
        let savedPostsCoordinator = SavedPostsCoordinator()
        let savedPostsNavigationController = UINavigationController(rootViewController: SavedPostsViewController(coordinator: savedPostsCoordinator))
        savedPostsNavigationController.title = NSLocalizedString("savedPosts", comment: "")
        savedPostsNavigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("savedPosts", comment: ""), image: UIImage(systemName: "bookmark"), tag: 3)
        return savedPostsNavigationController
    }
}
