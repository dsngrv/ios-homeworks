//
//  PostViewController.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 05.04.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    var postTitle: String = "Post"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        
        self.navigationItem.title = postTitle
        
        let bButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(bButtonPressed))
        
        navigationItem.rightBarButtonItem = bButton
    }
    
    @objc func bButtonPressed() {
        let infoViewController = InfoViewController()
        infoViewController.modalTransitionStyle = .coverVertical
        infoViewController.modalPresentationStyle = .pageSheet
        
        present(infoViewController, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
