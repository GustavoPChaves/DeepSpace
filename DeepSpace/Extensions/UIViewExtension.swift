//
//  UIViewExtension.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 22/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

extension UIView {
    
    func setGradient(colors: [CGColor], angle: Float = 0) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        
        gradient.frame = bounds
        gradient.colors = colors
        
        let alpha: Float = angle / 360
        let startPointX = powf(
            sinf(2 * Float.pi * ((alpha + 0.75) / 2)),
            2
        )
        let startPointY = powf(
            sinf(2 * Float.pi * ((alpha + 0) / 2)),
            2
        )
        let endPointX = powf(
            sinf(2 * Float.pi * ((alpha + 0.25) / 2)),
            2
        )
        let endPointY = powf(
            sinf(2 * Float.pi * ((alpha + 0.5) / 2)),
            2
        )
        
        gradient.endPoint = CGPoint(x: CGFloat(endPointX),y: CGFloat(endPointY))
        gradient.startPoint = CGPoint(x: CGFloat(startPointX), y: CGFloat(startPointY))
        
        layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    func removeGradient(layer: CAGradientLayer) {
        for index in 0..<self.layer.sublayers!.count {
            if self.layer.sublayers![index] == layer {
                self.layer.sublayers?.remove(at: index)
                break
            }
        }
    }
    
}
