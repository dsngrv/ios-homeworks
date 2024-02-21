//
//  FeedViewController.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 05.04.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let feedModel: FeedViewModelProtocol
    let coordinator: FeedCoordinator
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
//        textField.placeholder = "Enter the word..."
        textField.placeholder = NSLocalizedString("enterTheWord", comment: "")
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: NSLocalizedString("guess", comment: ""), titleColor: .white, action: {
            if self.feedModel.check(word: self.textField.text ?? " ") {
                self.guessLabel.text = NSLocalizedString("correct", comment: "")
                self.guessLabel.textColor = .green
                self.guessLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            } else {
                self.guessLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                self.guessLabel.text = NSLocalizedString("tryAgain", comment: "")
                self.guessLabel.textColor = .red
            }
        })
        return button
    }()
    
    private lazy var guessLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = NSLocalizedString("guessTheWord", comment: "")
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("open", comment: ""), for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_ :)), for: .touchUpInside)
        return button
    }()
    
    init(coordinator: FeedCoordinator) {
        self.feedModel = FeedViewModel()
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        coordinator.presentPost(navigationController: self.navigationController, title: NSLocalizedString("post", comment: ""))
    }
    
    private func setupLayout() {
        [actionButton, textField, checkGuessButton, guessLabel ].forEach({view.addSubview($0)})
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            textField.widthAnchor.constraint(equalToConstant: 300),
            textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            guessLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -16),
            guessLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            checkGuessButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            checkGuessButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            checkGuessButton.widthAnchor.constraint(equalToConstant: 200),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            actionButton.heightAnchor.constraint(equalToConstant: 44.0),
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
}
