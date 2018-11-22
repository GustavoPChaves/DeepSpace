//
//  SolarSystemARViewController.swift
//  DeepSpace
//
//  Created by João batista Romão on 20/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
class SolarSystemARViewController: UIViewController {
    
    @IBOutlet weak var scenaView: ARSCNView!
    
    var astronimicalObjects: [AstronomicalObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        scenaView.session.run(configuration)
        initialSettings()
        
        for i in 0..<astronimicalObjects.count{
            genesis(astronomicalBodies: astronimicalObjects[i])
        }
    }
    
    func initialSettings() {
        let sun = AstronomicalObject.init(scale: 0.2375, texture: "8k_sun", positionX: 0.0, positionY: 0.0, positionZ: -0.230, eulerAngle: 0.0, obliquity: 0.0)
        let mercury =  AstronomicalObject.init(scale: 0.015, texture: "2k_mercury", positionX: 0.0, positionY: 0.0, positionZ: 0.155, eulerAngle: 0.1, obliquity: 0.1)
        let venus = AstronomicalObject.init(scale: 0.038, texture: "2k_venus_surface", positionX: 0.0, positionY: 0.0, positionZ: 0.289, eulerAngle: 177.4, obliquity: 177.4)
        let earth = AstronomicalObject.init(scale: 0.04, texture: "8k_earth_daymap", positionX: 0.0, positionY: 0.0, positionZ: 0.4, eulerAngle: 23.45, obliquity: 23.45)
        let moon = AstronomicalObject.init(scale: 0.01, texture: "8k_moon", positionX: 0.05, positionY: 0.05, positionZ: 0.4, eulerAngle: 91.54, obliquity: 91.54)
        let uranus = AstronomicalObject.init(scale: 0.04, texture: "2k_uranus", positionX: 0.0, positionY: 0.0, positionZ: 0.9, eulerAngle: 7.86, obliquity: 7.86)
        self.astronimicalObjects.append(sun)
        self.astronimicalObjects.append(mercury)
        self.astronimicalObjects.append(venus)
        self.astronimicalObjects.append(earth)
        self.astronimicalObjects.append(moon)
        self.astronimicalObjects.append(uranus)
        
        //       Name:  diameter : scale: distance : scaleDistance: obliquity
        //        sun  1.391.016 = 54,52 = 0 = 0.0  : 0
        //        Mercury. 4.878  = 2,61 = 58.000.000 = 2,58 : 0.1
        //        Venus. = 12.104 = 1,05 = 108.000.000 = 1.38 : 177
        //        Earth. = 12.756 = 0.04 = 150.000.000 = 0.4 : 23
        //        moon   = 3.474  = 3.67 = 384.000 = 390.62 : 1.54
        //        Mars.  = 6.780 = 1.88 = 228.000.000 = 1.52 : 25
        //        Jupiter = 139,822 = 10.96 = 778.000.000 = 5.18   : 3
        //        Saturn = 116,464 = 9.13 = 1.427.000.000 = 9.51  :27
        //        Uranus = 50,724 = 3.97 = 2.870.000.000 = 19,133 : 98
        //        Neptune = 49,248 = 3,86 =  4.497.000.000 = 29,98 :30
        
    }
    
    func genesis(astronomicalBodies: AstronomicalObject) {
        let planetNode = SCNNode()
        planetNode.position = SCNVector3(astronomicalBodies.positionX,astronomicalBodies.positionY,astronomicalBodies.positionZ)
        planetNode.addChildNode(createPlanet(astronomicalBodies: astronomicalBodies, scale: astronomicalBodies.scale))
        scenaView.scene.rootNode.addChildNode(planetNode)
        
    }
    func createPlanet(astronomicalBodies: AstronomicalObject,scale: Float) -> SCNNode{
        let wrapperNode = SCNNode()
        let texturePlanet = SCNMaterial()
        texturePlanet.diffuse.contents = UIImage(named: astronomicalBodies.texture)
        
        if let virtualPlanet = SCNScene(named: "genericPlanet.scn", inDirectory: "Models.scnassets", options: nil) {
            
            for child in virtualPlanet.rootNode.childNodes{
                child.geometry?.firstMaterial?.lightingModel = .physicallyBased
                child.geometry?.materials = [texturePlanet]
                child.scale.x = scale
                child.scale.y = scale
                child.scale.z = scale
                child.eulerAngles.z =  astronomicalBodies.eulerAngle
                wrapperNode.addChildNode(child)
            }
        }else{
            print("Não foi possivel criar o planeta")
        }
        
        rotationAstronomicalBodies(astronomicalBodies: astronomicalBodies, node: wrapperNode)
        return wrapperNode
    }
    func rotationAstronomicalBodies(astronomicalBodies: AstronomicalObject, node: SCNNode){
        // y responsavel pela velocidade
        if astronomicalBodies.obliquity != 0.0{
            if astronomicalBodies.obliquity != -8.912835{
                let rotateOne = SCNAction.rotate(by: .pi, around: node.convertVector(SCNVector3(x: 1, y: astronomicalBodies.obliquity, z: 0), to: node.parent), duration: 5.0)
                let repeatForever = SCNAction.repeatForever(rotateOne)
                node.runAction(repeatForever)
            }else{//uranus
                let rotateOne = SCNAction.rotate(by: .pi, around: node.convertVector(SCNVector3(x: astronomicalBodies.obliquity, y: 1, z: 0), to: node.parent), duration: 5.0)
                let repeatForever = SCNAction.repeatForever(rotateOne)
                node.runAction(repeatForever)
            }
           
            
        }
      
    }
    
}

