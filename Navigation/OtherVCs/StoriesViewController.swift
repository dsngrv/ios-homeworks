//
//  StoriesViewController.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 30.11.2023.
//

import Foundation
import UIKit

final class StoriesViewController: UIViewController {
    
    var timer = Timer()
    
    private lazy var storiesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ИСТОРИЯ"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var storiesTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Очень большой и важный текст. Вы можете ознакомиться с ним и закрыть историю, когда закончится таймер(синяя полоска вверху экрана), а пока посмотрите на котика"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .red
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "heartCat"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var storiesProgress: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progressViewStyle = .default
        progress.setProgress(0.0, animated: false)
        progress.tintColor = .systemBlue
        progress.trackTintColor = .lightGray.withAlphaComponent(0.2)
        return progress
    }()
    
    private lazy var closeStoriesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.isHidden = true
        button.addTarget(self, action: #selector(closeStories), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createTimer()
        setupLayout()
    }
    
    private func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc private func timerAction() {
        if storiesProgress.progress != 1.0 {
            storiesProgress.progress += 0.001 / 1.0
        } else {
            timer.invalidate()
            print("timer stop")
            closeStoriesButton.isHidden = false
        }
    }
    
    @objc private func closeStories() {
        self.dismiss(animated: true)
    }
    
    private func setupLayout() {
        [storiesProgress, closeStoriesButton, storiesLabel, storiesTextLabel, imageView].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            storiesProgress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            storiesProgress.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            storiesProgress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            storiesProgress.heightAnchor.constraint(equalToConstant: 4),
            
            closeStoriesButton.topAnchor.constraint(equalTo: storiesProgress.bottomAnchor, constant: 8),
            closeStoriesButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            closeStoriesButton.heightAnchor.constraint(equalToConstant: 24),
            closeStoriesButton.widthAnchor.constraint(equalToConstant: 24),
            
            storiesLabel.topAnchor.constraint(equalTo: storiesProgress.bottomAnchor, constant: 40),
            storiesLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            storiesTextLabel.topAnchor.constraint(equalTo: storiesLabel.bottomAnchor, constant: 20),
            storiesTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            storiesTextLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            imageView.topAnchor.constraint(equalTo: storiesTextLabel.bottomAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
