//
//  Genesis.swift
//  DeepSpace
//
//  Created by João batista Romão on 25/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
import SceneKit
class Genesis {
    
    var solarSystem: [AstronomicalObject] = []
    
    init() {
        createSolarSystem()
    }
   
    
    func createSolarSystem(){
    
        let sun = AstronomicalObject.init(scale: 0.35,
                                          textures: "1k_sun",
                                          modelScn: "planetBaseGeneric.scn",
                                          positionX: 0.0,
                                          positionY: 0.0,
                                          positionZ: -0.35,
                                          eulerAngle: 180.0,
                                          durationRotation: 27)

        let mercury = AstronomicalObject.init(scale: 0.015,
                                               textures: "1k_mercury",
                                               modelScn: "planetBaseGeneric.scn",
                                               positionX: 0.0,
                                               positionY: 0.0,
                                               positionZ: 0.155,
                                               eulerAngle: 0.1,
                                               durationRotation: 58.66)

        let venus = AstronomicalObject.init(scale: 0.038,
                                            textures: "1k_venus_surface",
                                            modelScn: "planetBaseGeneric.scn",
                                            positionX: 0.0,
                                            positionY: 0.0,
                                            positionZ: 0.289,
                                            eulerAngle: 177.4,
                                            durationRotation: 121.0)

        let earth = AstronomicalObject.init(scale: 0.04,
                                            textures: "1k_earth_daymap",
                                            modelScn: "planetBaseGeneric.scn",
                                            positionX: 0.0,
                                            positionY: 0.0,
                                            positionZ: 0.4,
                                            eulerAngle: 23.27,
                                            durationRotation: 5.0)

        let moon = AstronomicalObject.init(scale: 0.01,
                                           textures: "1k_moon",
                                           modelScn: "planetBaseGeneric.scn",
                                           positionX: 0.05,
                                           positionY: 0.05,
                                           positionZ: 0.4,
                                           eulerAngle: 91.54,
                                           durationRotation: 29.4)

        let mars =  AstronomicalObject.init(scale: 0.021,
                                            textures: "1k_mars",
                                            modelScn: "planetBaseGeneric.scn",
                                            positionX: 0.0,
                                            positionY: 0.0,
                                            positionZ: 0.608,
                                            eulerAngle: 23.27,
                                            durationRotation: 5.2)

        let jupiter = AstronomicalObject.init(scale: 0.4384,
                                              textures: "1k_jupiter",
                                              modelScn: "planetBaseGeneric.scn",
                                              positionX: 0.0,
                                              positionY: 0.0,
                                              positionZ: 2.072,
                                              eulerAngle: 3.12,
                                              durationRotation: 2.08)

        let saturn = AstronomicalObject.init(scale: 0.3652,
                                             textures: "1k_saturn",
                                             modelScn: "planetsRings.scn",
                                             positionX: 0.0,
                                             positionY: 0.0,
                                             positionZ: 3.804,
                                             eulerAngle: 27,
                                             durationRotation: 2.29)
        //7.65
        let uranus = AstronomicalObject.init(scale: 0.1588,
                                             textures: "1k_uranus",
                                             modelScn: "planetBaseGeneric.scn",
                                             positionX: 0.0,
                                             positionY: 0.0,
                                             positionZ: 5.0,
                                             eulerAngle: 7.86,
                                             durationRotation: 3.34)
        //11.992
        let neptune = AstronomicalObject.init(scale: 0.1544,
                                              textures: "1k_neptune",
                                              modelScn: "planetBaseGeneric.scn",
                                              positionX: 0.0,
                                              positionY: 0.0,
                                              positionZ: 5.8,
                                              eulerAngle: 23.27,
                                              durationRotation: 3.33)

        solarSystem.append(contentsOf: [sun,mercury,venus,earth,moon,mars,jupiter,uranus,saturn,neptune])
    }
    
    //Create Note base for outhes nodes, for exemple Sun and earth
    func createPlanetNodeBase(astronomicalBodies: AstronomicalObject) -> SCNNode {
        let planetsNode = SCNNode()
        planetsNode.position = SCNVector3(astronomicalBodies.positionX,astronomicalBodies.positionY,astronomicalBodies.positionZ)
        if astronomicalBodies.textures[0] == "1k_sun"{
             planetsNode.addChildNode(createStar(astronomicalBodies: astronomicalBodies))
            print("passando aqui")
        }else{
              planetsNode.addChildNode(createPlanetAR(astronomicalBodies: astronomicalBodies))
        }
        return planetsNode
    }
    
    func createPlanetAR(astronomicalBodies: AstronomicalObject) -> SCNNode{
        let wrapperNode = SCNNode()
        var numberObjectsInModel = 0;
        if let virtualPlanet = SCNScene(named: astronomicalBodies.modelScn, inDirectory: "Models.scnassets", options: nil) {
            for child in virtualPlanet.rootNode.childNodes{
                child.geometry?.firstMaterial?.lightingModel = .physicallyBased
                child.geometry?.materials = [setTexture(textures: astronomicalBodies.textures)]
                child.scale.x = numberObjectsInModel > 0 ? 0.6 : astronomicalBodies.scale
                child.scale.y = numberObjectsInModel > 0 ? 0.05 : astronomicalBodies.scale
                child.scale.z = numberObjectsInModel > 0 ? 0.6 : astronomicalBodies.scale
                child.eulerAngles.z =  astronomicalBodies.eulerAngle
                wrapperNode.addChildNode(child)
                numberObjectsInModel+=1
            }
        }else{
            print("No possible create planet, model or 3d Scn not found")
        }
        
        rotationAstronomicalBodies(astronomicalBodies: astronomicalBodies, node: wrapperNode)
        return wrapperNode
    }
    
    func setTexture(textures: [String]) -> SCNMaterial{
        let texturePlanet = SCNMaterial()
        if textures.count > 1{
            texturePlanet.diffuse.contents = UIImage(named: textures[0])
            texturePlanet.normal.contents = UIImage(named: textures[1])
        }else{
            //Case plantes with rings rotation texture
            texturePlanet.diffuse.contents = UIImage(named: textures[0])
            let translation = SCNMatrix4MakeTranslation(0, -1, 0)
            let rotation = SCNMatrix4MakeRotation(Float.pi / 2, 0, 0, 1)
            let transform = SCNMatrix4Mult(translation, rotation)
            texturePlanet.diffuse.contentsTransform = transform
        }
        return texturePlanet
        
    }
    
    func createStar(astronomicalBodies: AstronomicalObject) -> SCNNode {
        let wrapperNode = SCNNode()
        if let virtualPlanet = SCNScene(named: astronomicalBodies.modelScn, inDirectory: "Models.scnassets", options: nil) {
            for child in virtualPlanet.rootNode.childNodes{
                child.geometry?.firstMaterial?.lightingModel = .physicallyBased
                child.geometry?.materials = [setTexture(textures: astronomicalBodies.textures)]
                child.scale.x = astronomicalBodies.scale
                child.scale.y = astronomicalBodies.scale
                child.scale.z = astronomicalBodies.scale
                child.eulerAngles.z =  astronomicalBodies.eulerAngle
               // setLight(node: child)
                wrapperNode.addChildNode(child)
            }
        }else{
            print("No possible create Star, model or 3d Scn not found")
        }
        
        rotationAstronomicalBodies(astronomicalBodies: astronomicalBodies, node: wrapperNode)
        
        return wrapperNode
    }
    
    func setLight(node: SCNNode) {
        let omniLight = SCNLight()
        omniLight.type = .ambient
        omniLight.intensity = 1000
        omniLight.temperature = 1000
        node.light = omniLight
        
    }
    func rotationAstronomicalBodies(astronomicalBodies: AstronomicalObject, node: SCNNode){
        // y responsavel pela velocidade
        if astronomicalBodies.obliquity != -8.912835{
            let rotateOne = SCNAction.rotate(by: .pi, around: node.convertVector(SCNVector3(x: 1, y: astronomicalBodies.obliquity, z: 0), to: node.parent), duration: TimeInterval(astronomicalBodies.durationRotation))
            let repeatForever = SCNAction.repeatForever(rotateOne)
            node.runAction(repeatForever)
          
        }else{//uranus
            let rotateOne = SCNAction.rotate(by: .pi, around: node.convertVector(SCNVector3(x: astronomicalBodies.obliquity, y: 1, z: 0), to: node.parent), duration: TimeInterval(astronomicalBodies.durationRotation))
            let repeatForever = SCNAction.repeatForever(rotateOne)
            node.runAction(repeatForever)
        }
    }
    func translationAstronimicalBodies(astronomicalBodies: AstronomicalObject, node: SCNNode){
          let trasnlation = SCNAction.moveBy(x: 0.0, y: 0.0, z: 3, duration: 5.0)
          node.runAction(trasnlation)
    }
    
   
}
