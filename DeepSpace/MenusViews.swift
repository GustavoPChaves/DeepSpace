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

protocol MenusViews {
    var motionManager: CMMotionManager{get set}
    func setBackground(myScene: SCNView)
}

extension MenusViews{
    func setBackground(myScene: SCNView){
        
        myScene.isUserInteractionEnabled = false
        
        guard let image = UIImage(named: "Background") else{
            fatalError("Failed to load background")
        }
        let background = SCNScene()
        myScene.scene = background
        myScene.allowsCameraControl = true
        
        let sphere = SCNSphere(radius: 20)
        sphere.firstMaterial?.isDoubleSided = true
        sphere.firstMaterial?.diffuse.contents = image
        
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3Make(0, 0, 0)
        background.rootNode.addChildNode(sphereNode)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 0)
        background.rootNode.addChildNode(cameraNode)
        
        
        
        guard motionManager.isDeviceMotionAvailable else {
            fatalError("Device motion is not available")
        }
        
        motionManager.deviceMotionUpdateInterval = 1/15
        motionManager.startDeviceMotionUpdates(to: .main) { (CMDeviceMotion, Error) in
            
            guard let data = CMDeviceMotion else{
                return
            }
            
            let attitude = data.attitude
            cameraNode.eulerAngles = SCNVector3Make(Float(attitude.roll - .pi/2), Float(attitude.yaw), Float(attitude.pitch))
        }
        
    }
}
