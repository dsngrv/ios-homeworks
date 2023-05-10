//
//  LogInViewController.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 10.05.2023.
//

import Foundation
import UIKit

class LogInViewContoller: UIViewController {
    
    private lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var loginView: UIView = {
        let login = UIView()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.backgroundColor = .white
        return login
    }()
    
    private lazy var logoView: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "logo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private lazy var loginTextField: UITextField = {
        let loginField = UITextField()
        loginField.translatesAutoresizingMaskIntoConstraints = false
        loginField.layer.backgroundColor = UIColor.systemGray6.cgColor
        loginField.layer.borderColor = UIColor.lightGray.cgColor
        loginField.textColor = .black
        loginField.layer.borderWidth = 0.5
        loginField.placeholder = "Email or phone"
        loginField.leftViewMode = .always
        loginField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        return loginField
    }()
    
    private lazy var passwordField: UITextField = {
        let pass = UITextField()
        pass.translatesAutoresizingMaskIntoConstraints = false
        pass.layer.backgroundColor = UIColor.systemGray6.cgColor
        pass.layer.borderColor = UIColor.lightGray.cgColor
        pass.textColor = .black
        pass.layer.borderWidth = 0.5
        pass.placeholder = "Password"
        pass.leftViewMode = .always
        pass.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        pass.isSecureTextEntry = true
        return pass
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("Log In", for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.cornerRadius = 10.0
        return button
    }()
    
    private lazy var separatorView: UIView = {
       let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    private lazy var stackView: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.clipsToBounds = true
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 0.0
        stack.layer.cornerRadius = 10.0
        stack.layer.borderWidth = 0.5
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.addArrangedSubview(loginTextField)
        stack.addArrangedSubview(separatorView)
        stack.addArrangedSubview(passwordField)
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(loginView)
        [logoView, stackView, loginButton].forEach{loginView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            loginView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            loginView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            loginView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            loginView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            loginView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoView.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 120),
            logoView.heightAnchor.constraint(equalToConstant: 100),
            logoView.widthAnchor.constraint(equalToConstant: 100),
            logoView.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: loginView.bottomAnchor)
        ])
    }
}
