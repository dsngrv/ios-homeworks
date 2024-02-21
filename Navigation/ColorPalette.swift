//
//  ColorPalette.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 20.02.2024.
//

import Foundation
import UIKit

struct ColorPalette {
    
    static var backgroundColor = UIColor.createColor(lightMode: .white, darkMode: UIColor(red: 0.16, green: 0.16, blue: 0.17, alpha: 1.00))
    
    static var cellBackgroundColor = UIColor.createColor(lightMode: UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00), darkMode: UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00))
    
    static var fieldsColor = UIColor.createColor(lightMode: .systemGray6, darkMode: UIColor(red: 0.22, green: 0.22, blue: 0.22, alpha: 1.00))
    
    static var tintColor = UIColor.createColor(lightMode: .lightGray, darkMode: UIColor(red: 0.29, green: 0.52, blue: 0.80, alpha: 1.00))
    
    static var textObjColor = UIColor.createColor(lightMode: .black, darkMode: .white)
    
}
