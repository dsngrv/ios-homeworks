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
    
    private lazy var loginTextField: UITextField = { [unowned self] in
        let loginField = UITextField()
        loginField.translatesAutoresizingMaskIntoConstraints = false
        loginField.layer.backgroundColor = UIColor.systemGray6.cgColor
        loginField.layer.borderColor = UIColor.lightGray.cgColor
        loginField.textColor = .black
        loginField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        loginField.autocapitalizationType = .none
        loginField.layer.borderWidth = 0.5
        loginField.placeholder = "Email or phone"
        loginField.leftViewMode = .always
        loginField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        loginField.keyboardType = UIKeyboardType.default
        loginField.returnKeyType = UIReturnKeyType.next
        loginField.clearButtonMode = UITextField.ViewMode.whileEditing
        loginField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        loginField.tag = 0
        loginField.delegate = self
        return loginField
    }()
    
    private lazy var passwordField: UITextField = {
        let pass = UITextField()
        pass.translatesAutoresizingMaskIntoConstraints = false
        pass.layer.backgroundColor = UIColor.systemGray6.cgColor
        pass.layer.borderColor = UIColor.lightGray.cgColor
        pass.textColor = .black
        pass.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        pass.autocapitalizationType = .none
        pass.layer.borderWidth = 0.5
        pass.placeholder = "Password"
        pass.isSecureTextEntry = true
        pass.leftViewMode = .always
        pass.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        pass.keyboardType = UIKeyboardType.default
        pass.returnKeyType = UIReturnKeyType.done
        pass.clearButtonMode = UITextField.ViewMode.whileEditing
        pass.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        pass.tag = 1
        pass.delegate = self
        return pass
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("Log In", for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = { [unowned self] in
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
        stack.addArrangedSubview(passwordField)
        return stack
    }()

//MARK: inits
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
// MARK: actions
    
    @objc func login() {
        let loginText = loginTextField.text ?? " "
        
        #if DEBUG
        if let testUser = TestUserService(login: loginText).user {
            let profile = ProfileViewController()
            profile.currentUser = testUser
            navigationController?.pushViewController(profile, animated: true)
        } else {
            showAlert(message: "Неверный логин")
        }
        #else
        if let currentUser = CurrentUserService(login: loginText).user {
            let profile = ProfileViewController()
            profile.currentUser = currentUser
            navigationController?.pushViewController(profile, animated: true)
        } else {
            showAlert(message: "Неверный логин")
        }
        #endif
    }
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRect.height
            let loginButtonBottomPointY = loginButton.frame.origin.y
            let keyboardOriginY = scrollView.frame.height - keyboardHeight
            let yOffset = keyboardOriginY < loginButtonBottomPointY ? loginButtonBottomPointY - keyboardOriginY - 16 : 0
            scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
//MARK: funcs
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_ :)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_ :)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(loginView)
        [logoView, stackView, loginButton].forEach{loginView.addSubview($0)}
    }
    
    private func setupConstraints() {
        
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
            
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -16)
        ])
    }
}

extension LogInViewContoller: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            passwordField.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
            
            login()
        }
        
        return true
    }
}
