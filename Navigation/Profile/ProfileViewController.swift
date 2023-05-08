//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 07.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var profileHeaderView: ProfileHeaderView = {
        
        let headerView = ProfileHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        return headerView
    }()
    
    private lazy var someButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("I do nothing...", for: .normal)
        button.setTitle("Nothing is done", for: .highlighted)
        button.backgroundColor = .black
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        subviews()
        constraints()
    }
    
    private func subviews() {
        view.addSubview(profileHeaderView)
        view.addSubview(someButton)
    }
    
    private func constraints() {

        let safeAreaGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileHeaderView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 0),
            profileHeaderView.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: 0),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            someButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            someButton.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 0),
            someButton.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: 0)
            ])
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
