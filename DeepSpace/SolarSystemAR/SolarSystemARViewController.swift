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
    
    @IBOutlet weak var sceneSolarSystem: ARSCNView!
    
    var solarSystem: [AstronomicalObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneSolarSystem.showsStatistics = true
        sceneSolarSystem.session.run(configuration)
        let genesis = Genesis.init()
        //let systemSolar = genesis.solarSystem
        for i in 0...(genesis.solarSystem.count-1){
            let systemSolar = genesis.createPlanetNodeBase(astronomicalBodies: genesis.solarSystem[i])
            sceneSolarSystem.scene.rootNode.addChildNode(systemSolar)
        }
       
        print("E que se faça a LUZ")
        
        
        
//        initialSettings()
//
//        for i in 0..<solarSystem.count{
//            genesis(astronomicalBodies: solarSystem[i])
//        }
    }
    
}
