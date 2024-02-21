//
//  UIColor+Extension.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 20.02.2024.
//

import Foundation
import UIKit

extension UIColor {
    
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return lightMode }
        
        return UIColor{ (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
    
}
