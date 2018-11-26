//
//  UINavigationBarExtension.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 22/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func removeSubview(_ view: UIView) {
        for subview in self.subviews {
            if subview == view {
                subview.removeFromSuperview()
            }
        }
    }
    
    func transparent() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
    }
    
    func removeTransparency() {
        self.setBackgroundImage(nil, for: .default)
        self.shadowImage = nil
    }
    
    func getNavigationBarFonts() -> [UIFont] {
        var fonts = [UIFont]()
        for subview in self.subviews {
            if !subview.subviews.isEmpty
                && subview.subviews[0].isKind(of: UILabel.self) {
                let label = subview.subviews[0] as! UILabel
                fonts.append(label.font)
            }
        }
        
        return fonts
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var barHeight: CGFloat = 44
        
        if size.height == 91 {
            barHeight = size.height
        }
        
        let newSize: CGSize = CGSize(width: self.frame.width, height: barHeight)
        return newSize
        
    }
    
}
