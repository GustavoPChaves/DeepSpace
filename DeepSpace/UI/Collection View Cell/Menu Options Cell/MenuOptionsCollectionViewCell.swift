//
//  MenuOptionsCollectionViewCell.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 21/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit

class MenuOptionsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var optionTitleLabel: UILabel!
    @IBOutlet weak private var gradientLayerView: UIView!
    
    private var gradientColors = [UIColor(rgb: 0x0088FF).cgColor,
                          UIColor(rgb: 0x9911AA).cgColor]
    
    var isGradientAdded = false
    var gradientLayer: CAGradientLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupGradient(bounds: CGRect) {
        gradientLayer = UIView.getGradient(colors: gradientColors, angle: -45.0, bounds: bounds)
        gradientLayer?.cornerRadius = 17
        gradientLayer?.masksToBounds = true
    }
    
    func showGradient() {
        if !isGradientAdded {
            gradientLayerView.layer.insertSublayer(gradientLayer!, at: 0)
            gradientLayerView.backgroundColor = UIColor.clear
            isGradientAdded = true
        }
        gradientLayerView.isHidden = false
    }
    
    func hideGradient() {
        gradientLayerView.isHidden = true
    }

}
