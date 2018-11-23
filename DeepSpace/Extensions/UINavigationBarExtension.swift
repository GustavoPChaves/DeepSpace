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
        self.isTranslucent = true
    }
    
    func removeTransparency() {
        self.setBackgroundImage(nil, for: .default)
        self.shadowImage = nil
    }
    
}
