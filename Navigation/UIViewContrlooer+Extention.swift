//
//  UIViewContrlooer+Extention.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 21.12.2023.
//

import Foundation
import UIKit

extension UIViewController {

    func showAlert(with title: String,
                   for errorMessage: String,
                   actions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: title,
                                      message: errorMessage,
                                      preferredStyle: .alert)
        if actions == nil {
            let action = UIAlertAction(title: " ", style: .default)
            alert.addAction(action)
        } else {
            actions?.forEach { alert.addAction($0) }
        }

        present(alert, animated: true)
    }
    
}
