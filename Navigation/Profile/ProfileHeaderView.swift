//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 18.04.2023.
//

import Foundation
import UIKit
import SnapKit

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
        status.textColor = .white
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
        textField.placeholder = NSLocalizedString("waitingStatus", comment: "")
        textField.addTarget(self, action: #selector(statusTextChanged(_ :)), for: .editingChanged)
        return textField
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("setStatus", comment: ""), for: .normal)
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
    
    func setView(user: User?) {
        if let user = user {
            self.fullNameLabel.text = user.fullName
            self.statusLabel.text = user.status
            self.avatarImageView.image = user.avatar
        }
    }
    
    private func setupLayout() {
        [avatarImageView, fullNameLabel, setStatusButton, statusLabel, statusTextField].forEach({addSubview($0)})
    }
    
    private func setupConstraints() {

        avatarImageView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.width.equalTo(120)
            make.top.equalTo(16)
            make.left.equalTo(16)
        }

        fullNameLabel.snp.makeConstraints { make in
            make.top.equalTo(27)
            make.left.equalTo(avatarImageView.snp_rightMargin).inset(-20)
            make.right.equalTo(-16)
        }

        statusLabel.snp.makeConstraints { make in
            make.bottom.equalTo(setStatusButton.snp_topMargin).inset(-60)
            make.left.equalTo(avatarImageView.snp_rightMargin).inset(-20)
            make.right.equalTo(-16)
        }

        statusTextField.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp_bottomMargin).inset(-12)
            make.height.equalTo(40)
            make.left.equalTo(avatarImageView.snp_rightMargin).inset(-20)
            make.right.equalTo(-16)
        }

        setStatusButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp_bottomMargin).inset(-26)
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(16)
        }

    }
}
