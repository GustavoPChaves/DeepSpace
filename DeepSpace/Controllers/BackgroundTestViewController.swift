//
//  BackgroundTestViewController.swift
//  DeepSpace
//
//  Created by Adriel Freire on 22/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit
import SceneKit
import CoreMotion

class BackgroundTestViewController: UIViewController, MenusViews {
    var motionManager: CMMotionManager = CMMotionManager()
    
    @IBOutlet weak var myScene: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground(myScene: myScene)
        
        
        
        
        
    }
    

    
}
