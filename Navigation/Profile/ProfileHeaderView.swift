//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 18.04.2023.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView {
        
    let profileAvatar: UIImageView = {

        let ava = UIImageView(
            frame: CGRect(
                x: 16,
                y: 114,
                width: 120,
                height: 120)
        )
        ava.image = UIImage(named: "doge")
        ava.clipsToBounds = true
        ava.layer.cornerRadius = 60.0
        ava.layer.borderWidth = 3.0
        ava.layer.borderColor = UIColor.white.cgColor
        
        return ava
    }()
    
    let userName: UILabel = {

        let name = UILabel(
            frame: CGRect(
                x: 156,
                y: 125,
                width: 200,
                height: 30)
        )
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.text = "Doge Coinov"
        name.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        name.textColor = .black
        
        return name
    }()
    
    let userStatus: UITextField = {

        let status = UITextField(
            frame: CGRect(
                x: 156,
                y: 198,
                width: 150,
                height: 20)
        )
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.text = "To the moon..."
        status.textColor = .gray
        
        return status
    }()
    
    lazy var statusButton: UIButton = {

        let button = UIButton(
            frame: CGRect(
                x: 16,
                y: 250,
                width: 358,
                height: 50)
        )
        button.setTitle("Show Status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4.0
        button.layer.masksToBounds = false
        
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(profileAvatar)
        self.addSubview(userName)
        self.addSubview(userStatus)
        self.addSubview(statusButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
