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
    
    enum AstronomicalBodies : String {
        case sun = "8k_sun"
        case moon = "8k_moon"
        case earth = "8k_earth_daymap"
        case mercury = "2k_mercury"
        case venus = "2k_venus_surface"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        scenaView.session.run(configuration)
        genesis(astronomicalBodies: .sun, scale: 0.1, positionX: 0.0, positionY: 0.0, positionZ: 0.0)
        genesis(astronomicalBodies: .earth, scale: 0.04, positionX: 0.0, positionY: 0.0, positionZ: 0.5)
        genesis(astronomicalBodies: .moon, scale: 0.005, positionX: 0.03, positionY:  0.03, positionZ:  0.55)
        genesis(astronomicalBodies: .mercury, scale: 0.02, positionX: 0.0, positionY: 0.0, positionZ: 0.2)
        genesis(astronomicalBodies: .venus, scale: 0.03, positionX: 0.0, positionY: 0.0, positionZ: 0.3)
        
        // Do any additional setup after loading the view.
    }
    
    func genesis(astronomicalBodies: AstronomicalBodies, scale: Float, positionX: Float, positionY: Float, positionZ: Float) {
        let planetNode = SCNNode()
        planetNode.position = SCNVector3(positionX,positionY,positionZ)
        planetNode.addChildNode(createPlanet(AstronomicalBodies: astronomicalBodies, scale: scale))
        scenaView.scene.rootNode.addChildNode(planetNode)
        
    }
    func createPlanet(AstronomicalBodies: AstronomicalBodies,scale: Float) -> SCNNode{
        let wrapperNode = SCNNode()
        let texturePlanet = SCNMaterial()
        texturePlanet.diffuse.contents = UIImage(named: AstronomicalBodies.rawValue)
        
        if let virtualPlanet = SCNScene(named: "sun.scn", inDirectory: "Models.scnassets", options: nil) {
            
            for child in virtualPlanet.rootNode.childNodes{
                child.geometry?.firstMaterial?.lightingModel = .physicallyBased
                child.geometry?.materials = [texturePlanet]
                child.scale.x = scale
                child.scale.y = scale
                child.scale.z = scale
                wrapperNode.addChildNode(child)
            }
        }else{
            print("Não foi possivel criar o planeta")
        }
        
        rotationAstronomicalBodies(node: wrapperNode)
        return wrapperNode
    }
    func rotationAstronomicalBodies(node: SCNNode){
        let rotateOne = SCNAction.rotateBy(x: 0.3, y: 2.4, z: 0, duration: 5.0)
        let repeatForever = SCNAction.repeatForever(rotateOne)
        node.runAction(repeatForever)
    }
}
