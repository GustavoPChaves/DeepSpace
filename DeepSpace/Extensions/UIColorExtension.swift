//
//  UIColorExtension.swift
//  foods_nano_challenge
//
//  Created by João Pedro Aragão on 19/10/18.
//  Copyright © 2018 João Pedro Aragão. All rights reserved.
//

import UIKit


// MARK: - Extension for initialize a color with hex value
extension UIColor {
    
    
    /// Init for int RGBA values
    ///
    /// - Parameters:
    ///   - red: Color's red int value (0...255)
    ///   - green: Color's green int value (0...255)
    ///   - blue: Color's blue int value (0...255)
    ///   - alpha: Color's alpha int value (0 or 1)
    convenience init(red: Int, green: Int, blue: Int, alpha: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }
    
    
    /// Init for hex value
    ///
    /// - Parameters:
    ///   - rgb: Hex value
    ///   - alpha: Color opacity (0/1)
    convenience init(rgb: Int, alpha: Int = 1) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: alpha
        )
    }
}
