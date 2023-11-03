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
        tabBarController.viewControllers = [createFeed(), createProfile()]
    }
        
    private func createFeed() -> UINavigationController {
        let feedCoordinator = FeedCoordinator()
        let feedNavigationController = UINavigationController(rootViewController: FeedViewController(coordinator: feedCoordinator))
            feedNavigationController.title = "Feed"
            feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName:"rectangle.3.group.bubble"), tag: 0)
        return feedNavigationController
    }

    private func createProfile() -> UINavigationController {
        let profileCoordinator = ProfileCoordinator()
        let loginFactory = MainFactory()
        let loginViewController = LogInViewContoller(coordinator: profileCoordinator)
        loginViewController.loginDelegate = loginFactory.makeLoginInspector()
        let profileNavigationController = UINavigationController(rootViewController: loginViewController)
        profileNavigationController.title = "Profile"
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        return profileNavigationController
        }
    
}
