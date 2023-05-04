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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        
        view.addSubview(profileHeaderView)
        view.addSubview(profileHeaderView.statusButton)

        profileHeaderView.frame = view.frame
        profileHeaderView.backgroundColor = .lightGray
        constraints()
        profileHeaderView.statusButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        print("Status: \(profileHeaderView.userStatus.text!)")
    }
    
    private func constraints() {

        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            profileHeaderView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: safeArea.topAnchor)
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
