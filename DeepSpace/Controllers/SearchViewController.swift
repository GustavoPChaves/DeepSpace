//
//  SearchViewController.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 27/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit
import CoreMotion
import SceneKit

class SearchViewController: UIViewController, BackgroundDefault {

    @IBOutlet weak var backgroundSceneView: SCNView!
    var motionManager: CMMotionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackground(myScene: backgroundSceneView)
    }

}
