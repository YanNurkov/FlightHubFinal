//
//  Fonts.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import UIKit

extension UIFont {
    static func customFont(type: FontsType, size: CGFloat) -> UIFont {
        if let font = UIFont(name: type.rawValue, size: size) {
            return font
        } else {
            print("Failed to load font: \(type.rawValue)")
            return UIFont.systemFont(ofSize: size)
        }
    }
}
