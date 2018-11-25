//
//  UINavigationControllerExtension.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 25/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    override open var preferredStatusBarStyle : UIStatusBarStyle {
        return UIApplication.topViewController()?.preferredStatusBarStyle ?? .lightContent
    }
}
