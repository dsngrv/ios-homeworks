//
//  CustomButton.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 10.10.2023.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    var closure: (() -> Void)
    
    init(title: String, titleColor: UIColor, action: @escaping () -> Void) {
        closure = action
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        setTitleColor(titleColor, for: .normal)
        layer.cornerRadius = 10.0
        clipsToBounds = true
        alpha = 1
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped() {
        closure()
    }
    
}
