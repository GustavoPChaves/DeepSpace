//
//  Genesis.swift
//  DeepSpace
//
//  Created by João batista Romão on 25/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

class Genesis {
  
    func createSolarSystem() -> [AstronomicalObject]{
        var solarSystem: [AstronomicalObject] = []
                
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

        solarSystem.append(sun)
        solarSystem.append(mercury)
        solarSystem.append(venus)
        solarSystem.append(earth)
        solarSystem.append(moon)
        solarSystem.append(mars)
        solarSystem.append(jupiter)
        solarSystem.append(uranus)
        solarSystem.append(saturn)
        solarSystem.append(neptune)
        
        return solarSystem
    }
    
    
    
}
