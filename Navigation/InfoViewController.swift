//
//  InfoViewController.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 06.04.2023.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var callAlertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Call Alert", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(callAlertButton)
        
        self.view.backgroundColor = .magenta
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            callAlertButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0
            ),
            callAlertButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0
            ),
            callAlertButton.centerYAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerYAnchor
            ),
            callAlertButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
        
        callAlertButton.addTarget(self, action: #selector(callAlertButtonPressed), for: .touchUpInside)

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
