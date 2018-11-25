//
//  Astronomicalobject.swift
//  DeepSpace
//
//  Created by João batista Romão on 21/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

class AstronomicalObject {
    var scale = Float()
    var textures = [String()]
    var modelScn = String()
    var positionX = Float()
    var positionY = Float()
    var positionZ = Float()
    var eulerAngle = Float()
    var obliquity = Float()
    var durationRotation =  Float()
    init(scale: Float, textures: String, modelScn: String, positionX : Float, positionY : Float, positionZ : Float, eulerAngle: Float, durationRotation : Float) {
        self.scale = scale
        self.modelScn = modelScn
        self.positionX = positionX
        self.positionY = positionY
        self.positionZ = positionZ
        self.textures = {
           return FuncionsAuxiliaries.getNameAlltextures(nameObject: textures)
        }()
        self.eulerAngle =  {
            return FuncionsAuxiliaries.converToRadians(degrees: eulerAngle)
        }()
        self.obliquity = {
           return FuncionsAuxiliaries.getVectorAngleObject(degress: eulerAngle)
        }()
        self.durationRotation = durationRotation
    }
    
  
    
}
