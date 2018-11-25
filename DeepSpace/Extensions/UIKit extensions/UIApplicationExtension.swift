//
//  UIApplicationExtension.swift
//  foods_nano_challenge
//
//  Created by João Pedro Aragão on 23/10/18.
//  Copyright © 2018 João Pedro Aragão. All rights reserved.
//

import UIKit


// MARK: - Extension for getting the current presented view controller
extension UIApplication {
    
    
    /// Recursive function which gets the current presented view controller
    ///
    /// - Parameter base: The base view controller of the hierarchy
    /// - Returns: The current presented view controller
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}
