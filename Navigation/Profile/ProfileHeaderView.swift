//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 18.04.2023.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText: String
        
    private let avatarImageView: UIImageView = {
        let ava = UIImageView()
        ava.translatesAutoresizingMaskIntoConstraints = false
        ava.image = UIImage(named: "doge")
        ava.clipsToBounds = true
        ava.layer.cornerRadius = 60.0
        ava.layer.borderWidth = 3.0
        ava.layer.borderColor = UIColor.white.cgColor
        return ava
    }()
    
    private let fullNameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.text = "Doge Coinov"
        name.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        name.textColor = .black
        return name
    }()
    
    private let statusLabel: UILabel = {
        let status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.text = "To the moon..."
        status.textColor = .gray
        return status
    }()
    
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.textColor = .black
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        textField.leftViewMode = .always
        textField.placeholder = "Waiting for something..."
        textField.addTarget(self, action: #selector(statusTextChanged(_ :)), for: .editingChanged)
        return textField
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set Status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4.0
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        self.statusText = statusLabel.text!
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        self.statusText = statusTextField.text!
    }
    
    @objc private func buttonPressed() {
        statusLabel.text = statusText
        print(statusLabel.text!)
    }
    
    private func setupLayout() {
        [avatarImageView, fullNameLabel, setStatusButton, statusLabel, statusTextField].forEach({addSubview($0)})
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            fullNameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 20),
            fullNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -56),
            statusLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 20),
            statusLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 20),
            statusTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 26),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            setStatusButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])
    }
}
