//
//  MenusViews.swift
//  DeepSpace
//
//  Created by Adriel Freire on 22/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
import SceneKit
import CoreMotion

protocol BackgroundDefault {
    var motionManager: CMMotionManager{get set}
    func setBackground(myScene: SCNView)
}

extension BackgroundDefault{
    func setBackground(myScene: SCNView){
        
        myScene.isUserInteractionEnabled = false
        
        guard let image = UIImage(named: "Apod") else{
            fatalError("Failed to load background")
        }
        let background = SCNScene()
        myScene.scene = background
        myScene.allowsCameraControl = true
        
        
        let plane = SCNPlane(width: 30, height: 30)
        plane.firstMaterial?.diffuse.contents = image
//        sphere.firstMaterial?.isDoubleSided = true
        
        
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3Make(0, 0, -20
        )
//        planeNode.rotation = SCNVector4Make(<#T##x: Float##Float#>, <#T##y: Float##Float#>, <#T##z: Float##Float#>, <#T##w: Float##Float#>)
        background.rootNode.addChildNode(planeNode)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 0)
        background.rootNode.addChildNode(cameraNode)
        
        
        
        guard motionManager.isDeviceMotionAvailable else {
            fatalError("Device motion is not available")
        }
        
        motionManager.deviceMotionUpdateInterval = 1/60
        motionManager.startDeviceMotionUpdates(to: .main) { (CMDeviceMotion, Error) in

            guard let data = CMDeviceMotion else{
                return
            }
            
            let gravity = data.gravity
            cameraNode.position = SCNVector3Make(Float(gravity.x) * -3, Float(gravity.y)*3, 0)

            
        }
        
    }
}
