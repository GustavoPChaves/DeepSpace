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
    
    func blurredView(withFrame frame: CGRect = CGRect.zero, opacity: CGFloat = 0.5, backgroundColor: UIColor = .clear, insertAt: Int = 0) {
        let blurredView = UIView.getBlurredView(withFrame: frame, opacity: opacity, backgroundColor: backgroundColor)
        self.removeBlurredSubview(view: blurredView)
        self.insertSubview(blurredView, at: insertAt)
        
    }
    
    func removeBlurredSubview(view: UIView) {
        for view in subviews {
            for subview in view.subviews {
                for subsubview in subview.subviews {
                    if subsubview.isKind(of: UIVisualEffectView.self) {
                        view.removeFromSuperview()
                        return
                    }
                }
            }
        }
    }
    
    func gradientLayer(colors: [CGColor], angle: Float = 0, bounds: CGRect = CGRect.zero, insertAt: Int = 0) {
        let gradient = UIView.getGradient(colors: colors, angle: angle, bounds: bounds)
        self.removeGradientLayer()
        
        let view = UIView(frame: bounds)
        view.backgroundColor = UIColor.clear
        view.layer.addSublayer(gradient)
        
        self.insertSubview(view, at: insertAt)
    }
    
    func removeGradientLayer() {
        for view in subviews {
            if let sublayers = view.layer.sublayers {
                for sublayer in sublayers {
                    if sublayer.isKind(of: CAGradientLayer.self) {
                        view.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    func applyShadow(radius: CGFloat = 13,
                     borderWidth: CGFloat = 1,
                     color: CGColor = UIColor(red: 0,
                                              green: 0,
                                              blue: 0,
                                              alpha: 0.5).cgColor,
                     offset: CGSize = CGSize.zero,
                     blur: CGFloat = 0,
                     alpha: Float = 0.5,
                     layerFrame: CGRect = CGRect.zero) {
        if let tableViewCell = self as? UITableViewCell {
            tableViewCell.contentView.layer.cornerRadius = radius
            tableViewCell.contentView.layer.borderWidth = borderWidth
            tableViewCell.contentView.layer.borderColor = UIColor.clear.cgColor
            tableViewCell.contentView.layer.masksToBounds = true
        } else if let collectionViewCell = self as? UICollectionViewCell {
            collectionViewCell.contentView.layer.cornerRadius = radius
            collectionViewCell.contentView.layer.borderWidth = borderWidth
            collectionViewCell.contentView.layer.borderColor = UIColor.clear.cgColor
            collectionViewCell.contentView.layer.masksToBounds = true
        }
        
        self.layer.shadowColor = color
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = blur
        self.layer.shadowOpacity = alpha
        self.layer.masksToBounds = false
        
        self.layer.shadowPath = UIBezierPath(roundedRect: layerFrame,
                                             cornerRadius: radius).cgPath
        self.layer.backgroundColor = UIColor.clear.cgColor
        
    }
    
}
