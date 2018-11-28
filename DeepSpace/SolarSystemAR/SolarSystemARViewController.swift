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
    
    var solarSystem: [AstronomicalObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        scenaView.session.run(configuration)
        initialSettings()
        
        for i in 0..<solarSystem.count{
            genesis(astronomicalBodies: solarSystem[i])
        }
    }
    
    func initialSettings() {
        //2375
        
        let sun = AstronomicalObject.init(scale: 0.35,
                                          textures: "8k_sun",
                                          modelScn: "genericPlanet.scn",
                                          positionX: 0.0, positionY: 0.0,
                                          positionZ: -0.35,
                                          eulerAngle: 180.0,
                                          durationRotation: 27)
        
        let mercury = AstronomicalObject.init(scale: 0.015,
                                              textures: "2k_mercury",
                                              modelScn: "genericPlanet.scn",
                                              positionX: 0.0,
                                              positionY: 0.0,
                                              positionZ: 0.155,
                                              eulerAngle: 0.1,
                                              durationRotation: 58.66)
        
        let venus = AstronomicalObject.init(scale: 0.038,
                                            textures: "2k_venus_surface",
                                            modelScn: "genericPlanet.scn",
                                            positionX: 0.0,
                                            positionY: 0.0,
                                            positionZ: 0.289,
                                            eulerAngle: 177.4,
                                            durationRotation: 121.0)
        
        let earth = AstronomicalObject.init(scale: 0.04,
                                            textures: "8k_earth_daymap",
                                            modelScn: "genericPlanet.scn",
                                            positionX: 0.0,
                                            positionY: 0.0,
                                            positionZ: 0.4,
                                            eulerAngle: 23.27,
                                            durationRotation: 5.0)
        
        let moon = AstronomicalObject.init(scale: 0.01,
                                           textures: "8k_moon",
                                           modelScn: "genericPlanet.scn",
                                           positionX: 0.05,
                                           positionY: 0.05,
                                           positionZ: 0.4,
                                           eulerAngle: 91.54,
                                           durationRotation: 29.4)
        
        let mars =  AstronomicalObject.init(scale: 0.021,
                                            textures: "2k_mars",
                                            modelScn: "genericPlanet.scn",
                                            positionX: 0.0,
                                            positionY: 0.0,
                                            positionZ: 0.608,
                                            eulerAngle: 23.27,
                                            durationRotation: 5.2)
        
        let jupiter = AstronomicalObject.init(scale: 0.4384,
                                              textures: "2k_jupiter",
                                              modelScn: "genericPlanet.scn",
                                              positionX: 0.0,
                                              positionY: 0.0,
                                              positionZ: 2.072,
                                              eulerAngle: 3.12,
                                              durationRotation: 2.08)
        
        let saturn = AstronomicalObject.init(scale: 0.3652,
                                             textures: "2k_saturn",
                                             modelScn: "planetsRings.scn",
                                             positionX: 0.0,
                                             positionY: 0.0,
                                             positionZ: 3.804,
                                             eulerAngle: 27,
                                             durationRotation: 2.29)
        //7.65
        let uranus = AstronomicalObject.init(scale: 0.1588,
                                             textures: "2k_uranus",
                                             modelScn: "genericPlanet.scn",
                                             positionX: 0.0,
                                             positionY: 0.0,
                                             positionZ: 5.0,
                                             eulerAngle: 7.86,
                                             durationRotation: 3.34)
        //11.992
        let neptune = AstronomicalObject.init(scale: 0.1544,
                                              textures: "2k_neptune",
                                              modelScn: "genericPlanet.scn",
                                              positionX: 0.0,
                                              positionY: 0.0,
                                              positionZ: 5.8,
                                              eulerAngle: 23.27,
                                              durationRotation: 3.33)

        
        self.solarSystem.append(sun)
        self.solarSystem.append(mercury)
        self.solarSystem.append(venus)
        self.solarSystem.append(earth)
        self.solarSystem.append(moon)
        self.solarSystem.append(mars)
        self.solarSystem.append(jupiter)
        self.solarSystem.append(uranus)
        self.solarSystem.append(saturn)
        self.solarSystem.append(neptune)
      
        
    }
    
    func genesis(astronomicalBodies: AstronomicalObject) {
        let planetNode = SCNNode()
        planetNode.position = SCNVector3(astronomicalBodies.positionX,astronomicalBodies.positionY,astronomicalBodies.positionZ)
        planetNode.addChildNode(createPlanet(astronomicalBodies: astronomicalBodies, scale: astronomicalBodies.scale))
        scenaView.scene.rootNode.addChildNode(planetNode)
        
    }
    func createPlanet(astronomicalBodies: AstronomicalObject,scale: Float) -> SCNNode{
        let wrapperNode = SCNNode()
    
        var numberTexture = 0;
        if let virtualPlanet = SCNScene(named: astronomicalBodies.modelScn, inDirectory: "Models.scnassets", options: nil) {
            for child in virtualPlanet.rootNode.childNodes{
                let texturePlanet = SCNMaterial()
                texturePlanet.diffuse.contents = UIImage(named: astronomicalBodies.textures[numberTexture])
                if  numberTexture > 0 {
                    let translation = SCNMatrix4MakeTranslation(0, -1, 0)
                    let rotation = SCNMatrix4MakeRotation(Float.pi / 2, 0, 0, 1)
                    let transform = SCNMatrix4Mult(translation, rotation)
                    texturePlanet.diffuse.contentsTransform = transform
                }
               
                child.geometry?.firstMaterial?.lightingModel = .physicallyBased
                child.geometry?.materials = [texturePlanet]
                child.scale.x = numberTexture > 0 ? 0.6 : scale
                child.scale.y = numberTexture > 0 ? 0.05 : scale
                child.scale.z = numberTexture > 0 ? 0.6 : scale
                child.eulerAngles.z =  astronomicalBodies.eulerAngle
               
                wrapperNode.addChildNode(child)
                numberTexture+=1
                
            }
        }else{
            print("Não foi possivel criar o planeta")
        }
        
        rotationAstronomicalBodies(astronomicalBodies: astronomicalBodies, node: wrapperNode)
        return wrapperNode
    }
    
    func rotationAstronomicalBodies(astronomicalBodies: AstronomicalObject, node: SCNNode){
        // y responsavel pela velocidade
            if astronomicalBodies.obliquity != -8.912835{
                let rotateOne = SCNAction.rotate(by: .pi, around: node.convertVector(SCNVector3(x: 1, y: astronomicalBodies.obliquity, z: 0), to: node.parent), duration: TimeInterval(astronomicalBodies.durationRotation))
                let repeatForever = SCNAction.repeatForever(rotateOne)
                let trasnlation = SCNAction.moveBy(x: 0.0, y: 0.0, z: 3, duration: 5.0)
                node.runAction(repeatForever)
                node.runAction(trasnlation)
            }else{//uranus
                let rotateOne = SCNAction.rotate(by: .pi, around: node.convertVector(SCNVector3(x: astronomicalBodies.obliquity, y: 1, z: 0), to: node.parent), duration: TimeInterval(astronomicalBodies.durationRotation))
                let repeatForever = SCNAction.repeatForever(rotateOne)
                node.runAction(repeatForever)
            }
        
      
    }
    
}

//REal datas
//        let sun = AstronomicalObject.init(scale: 0.35, textures: ["8k_sun"], modelScn: "genericPlanet.scn", positionX: 0.0, positionY: 0.0, positionZ: -0.35, eulerAngle: 180.0, obliquity: 180.0, durationRotation: 135)
//        let mercury =  AstronomicalObject.init(scale: 0.015, textures: ["2k_mercury"], modelScn: "genericPlanet.scn", positionX: 0.0, positionY: 0.0, positionZ: 0.155, eulerAngle: 0.1, obliquity: 0.1, durationRotation: 293.33)
//        let venus = AstronomicalObject.init(scale: 0.038, textures: ["2k_venus_surface"], modelScn: "genericPlanet.scn", positionX: 0.0, positionY: 0.0, positionZ: 0.289, eulerAngle: 177.4, obliquity: 177.4, durationRotation: 1215.0)
//        let earth = AstronomicalObject.init(scale: 0.04, textures: ["8k_earth_daymap"], modelScn: "genericPlanet.scn", positionX: 0.0, positionY: 0.0, positionZ: 0.4, eulerAngle: 23.27, obliquity: 23.27, durationRotation: 5.0)
//        let moon = AstronomicalObject.init(scale: 0.01, textures: ["8k_moon"], modelScn: "genericPlanet.scn", positionX: 0.05, positionY: 0.05, positionZ: 0.4, eulerAngle: 91.54, obliquity: 91.54, durationRotation: 147.5)
//        let mars =  AstronomicalObject.init(scale: 0.021, textures: ["2k_mars"], modelScn: "genericPlanet.scn", positionX: 0.0, positionY: 0.0, positionZ: 0.608, eulerAngle: 23.27, obliquity: 23.27, durationRotation: 5.2)
//        let jupiter = AstronomicalObject.init(scale: 0.4384, textures: ["2k_jupiter"], modelScn: "genericPlanet.scn", positionX: 0.0, positionY: 0.0, positionZ: 2.072, eulerAngle: 3.12, obliquity: 3.12, durationRotation: 2.08)
//        let saturn = AstronomicalObject.init(scale: 0.3652, textures: ["2k_saturn","2k_saturn_ring_alpha"], modelScn: "planetsRings.scn", positionX: 0.0, positionY: 0.0, positionZ: 3.804, eulerAngle: 27, obliquity: 27, durationRotation: 2.29)
//        //7.65
//        let uranus = AstronomicalObject.init(scale: 0.04, textures: ["2k_uranus"], modelScn: "genericPlanet.scn", positionX: 0.0, positionY: 0.0, positionZ: 5.0, eulerAngle: 7.86, obliquity: 7.86, durationRotation: 3.34)
//        //11.992
//        let neptune = AstronomicalObject.init(scale: 0.1544, textures: ["2k_neptune"], modelScn: "genericPlanet.scn", positionX: 0.0, positionY: 0.0, positionZ: 5.1, eulerAngle: 30.0, obliquity:30.0, durationRotation: 3.33)

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
