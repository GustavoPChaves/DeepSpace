//
//  UIViewExtension.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 22/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

extension UIView {
    
    static func getGradient(colors: [CGColor], angle: Float = 0, bounds: CGRect = CGRect.zero) -> CAGradientLayer {
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
        
        return gradient
    }
    
    static func getBlurredView(withFrame frame: CGRect = CGRect.zero, opacity: CGFloat = 0.5, backgroundColor: UIColor = .clear) -> UIView {
        //only apply the blur if the user hasn't disabled transparency effects
        let view = UIView(frame: frame)
        view.backgroundColor = backgroundColor
        
        let subview = UIView(frame: frame)
        subview.backgroundColor = UIColor.clear
        
        
        if !UIAccessibility.isReduceTransparencyEnabled {
            
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = frame
            
            subview.addSubview(blurEffectView)
            subview.alpha = opacity
        }
        
        view.addSubview(subview)
        return view
        
    }
    
    func blurredView(withFrame frame: CGRect = CGRect.zero, opacity: CGFloat = 0.5, backgroundColor: UIColor = .clear) {
        let blurredView = UIView.getBlurredView(withFrame: frame, opacity: opacity, backgroundColor: backgroundColor)
        let _ = self.removeBlurredSubview(view: blurredView)
        self.insertSubview(blurredView, at: 0)
        
    }
    
    func removeBlurredSubview(view: UIView) -> Bool {
        for view in subviews {
            for subview in view.subviews {
                for subsubview in subview.subviews {
                    if subsubview.isKind(of: UIVisualEffectView.self) {
                        view.removeFromSuperview()
                        return true
                    }
                }
            }
        }
        return false
    }
    
}
