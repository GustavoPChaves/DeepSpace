//
//  ViewController.swift
//  DeepSpace
//
//  Created by Adriel Freire on 12/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit
import SceneKit
import CoreMotion

class ViewController: UIViewController, BackgroundDefault {

    
    var motionManager: CMMotionManager = CMMotionManager()
    
    @IBOutlet weak var myScene: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setBackground(myScene: myScene)
    }
    

}

