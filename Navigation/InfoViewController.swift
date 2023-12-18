//
//  InfoViewController.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 06.04.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .red
        return label
    }()
    
    private lazy var periodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private lazy var callAlertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Call Alert", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(callAlertButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemMint
        setupLayout()
        setTitle()
        getOrbitalPeriod()
    }
    
    @objc func callAlertButtonPressed() {
        let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"Cancel\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setTitle() {
        NetworkManager.requestTitle(for: AppConfiguration.randomTitle) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let title):
                    self?.titleLabel.text = title
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func getOrbitalPeriod(){
        
        getPlanet { [ weak self] result in
            switch result {
            case .success(let planet):
                DispatchQueue.main.async {
                    self?.periodLabel.text = "\(planet.name)'s orbital period equal \(planet.orbitalPeriod)"
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    private func getPlanet(completion: @escaping (Result<Planets,NetworkError>) -> Void){
            guard let url = AppConfiguration.planets.url else {return}
            NetworkManager.decode(request: URLRequest(url: url), completion: completion)
        }
    
    private func setupLayout() {
        [callAlertButton, titleLabel, periodLabel].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            callAlertButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            callAlertButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            callAlertButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            callAlertButton.heightAnchor.constraint(equalToConstant: 44.0),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 200),
            
            periodLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            periodLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            periodLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
