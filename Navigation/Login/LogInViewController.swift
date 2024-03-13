//
//  LogInViewController.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 10.05.2023.
//

import Foundation
import UIKit

class LogInViewContoller: UIViewController {
    
    var loginDelegate: LoginViewControllerDelegate!
    let coordinator: ProfileCoordinator
    
    let localAuthService = LocalAuthorizationService()
    
    private lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var loginView: UIView = {
        let login = UIView()
        login.translatesAutoresizingMaskIntoConstraints = false
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
        loginField.layer.backgroundColor = ColorPalette.fieldsColor.cgColor
        loginField.layer.borderColor = ColorPalette.tintColor.cgColor
        loginField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        loginField.autocapitalizationType = .none
        loginField.layer.borderWidth = 0.5
        loginField.placeholder = NSLocalizedString("emailOrPhone", comment: "")
        loginField.leftViewMode = .always
        loginField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: 10))
        loginField.keyboardType = UIKeyboardType.emailAddress
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
        pass.layer.backgroundColor = ColorPalette.fieldsColor.cgColor
        pass.layer.borderColor = ColorPalette.tintColor.cgColor
        pass.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        pass.autocapitalizationType = .none
        pass.layer.borderWidth = 0.5
        pass.placeholder = NSLocalizedString("pass", comment: "")
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
    
    private lazy var loginButton: CustomButton = {
        let button = CustomButton(title: NSLocalizedString("login", comment: ""), titleColor: .white) {
            self.login()
        }
        return button
    }()
    
    private lazy var signUpButton: CustomButton = {
        let button = CustomButton(title: NSLocalizedString("signup", comment: ""), titleColor: .white) {
            self.showAlertSignUp()
        }
        return button
    }()
    
    private lazy var loginViaBiometryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = localAuthService.avaliableBiometryType.image
        
        var tintedImage = UIImage(systemName: image)?.withRenderingMode(.alwaysTemplate)
        tintedImage = tintedImage?.withTintColor(.white)
        
        let title = NSLocalizedString("loginvia", comment: "")
        
        let attributedTitle = NSMutableAttributedString()
        attributedTitle.append(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = tintedImage
        let imageString = NSMutableAttributedString(attachment: imageAttachment)
        
        attributedTitle.append(imageString)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(loginViaBiometry), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .systemBlue
        return indicator
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
        stack.layer.borderColor = ColorPalette.tintColor.cgColor
        stack.addArrangedSubview(loginTextField)
        stack.addArrangedSubview(passwordField)
        return stack
    }()
    
    //MARK: inits
    
    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.backgroundColor
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
    
    
    @objc func loginViaBiometry() {
        
        localAuthService.authorizeIfPossible { success, error in
            if success {
#if DEBUG
                let testUser = TestUserService()
                DispatchQueue.main.async {
                    self.coordinator.presentProfile(navigationController: self.navigationController, user: testUser.getUser())
                }
#else
                let currentUser = CurrentUserService()
                DispatchQueue.main.async {
                    self.coordinator.presentProfile(navigationController: self.navigationController, user: currentUser.getUser())
                }
#endif
            } else {
                self.showAlert(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("errorBiom", comment: ""))
            }
            
        }
        
        if case .none  =  localAuthService.avaliableBiometryType {
            loginViaBiometryButton.isHidden = true
        }
        
    }
    
    //MARK: funcs
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func login() {
        if let email = self.loginTextField.text, let password = self.passwordField.text {
            if email == " " && password == " " {
                self.showAlert(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("emptyEmailFields", comment: ""))
            } else {
                if !email.isValidMail(email: email) {
                    self.showAlert(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("enterCorrectEmail", comment: ""))
                } else if !password.isValidPassword(password: password) {
                    self.showAlert(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("enterCorrectPass", comment: ""))
                } else {
                    self.loginDelegate.checkCredentials(email: self.loginTextField.text!, password: self.passwordField.text!) { result in
                        switch result {
                        case .success(let authResult):
                            guard authResult.user.email != nil else { return }
                            
#if DEBUG
                            let testUser = TestUserService()
                            self.coordinator.presentProfile(navigationController: self.navigationController, user: testUser.getUser())
#else
                            let currentUser = CurrentUserService()
                            self.coordinator.presentProfile(navigationController: self.navigationController, user: currentUser.getUser())
#endif
                            
                        case .failure(let error):
                            self.showAlert(title: NSLocalizedString("error", comment: ""), message: error.localizedDescription)
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    func showAlertSignUp() {
        let alert = UIAlertController(title: NSLocalizedString("userReg", comment: ""), message:NSLocalizedString("regInfo", comment: ""), preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { action in
            if let email = self.loginTextField.text, let password = self.passwordField.text {
                if email == " " && password == " " {
                    self.showAlert(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("emptyEmailFields", comment: ""))
                } else {
                    if !email.isValidMail(email: email) {
                        self.showAlert(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("enterCorrectEmail", comment: ""))
                    } else if !password.isValidPassword(password: password) {
                        self.showAlert(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("enterCorrectPass", comment: ""))
                    } else {
                        self.loginDelegate.signUp(email: self.loginTextField.text!, password: self.passwordField.text!) { result  in
                            switch result {
                            case .success(let authResult):
                                guard authResult.user.email != nil else { return }
                                self.showAlert(title: NSLocalizedString("welcome", comment: "") ,message: NSLocalizedString("canLogin", comment: ""))
                            case .failure(let error):
                                self.showAlert(title: NSLocalizedString("error", comment: ""), message: error.localizedDescription)
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel)
        alert.addTextField { field in
            field.text = self.loginTextField.text!
            field.isUserInteractionEnabled = false
            field.returnKeyType = .next
        }
        alert.addTextField { field in
            field.text = self.passwordField.text!
            field.isSecureTextEntry = false
            field.isUserInteractionEnabled = false
            field.returnKeyType = .done
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
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
        [logoView, stackView, loginButton, signUpButton, indicator, loginViaBiometryButton].forEach{loginView.addSubview($0)}
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
            
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            signUpButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            signUpButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            loginViaBiometryButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 16),
            loginViaBiometryButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginViaBiometryButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginViaBiometryButton.heightAnchor.constraint(equalToConstant: 50),
            loginViaBiometryButton.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -16),
            
            indicator.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor),
            indicator.topAnchor.constraint(equalTo: passwordField.topAnchor, constant: 2),
            indicator.bottomAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: -2)
        ])
    }
}

extension LogInViewContoller: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            passwordField.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
        }
        
        return true
    }
}
