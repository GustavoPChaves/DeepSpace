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
    var texture = String()
    var positionX = Float()
    var positionY = Float()
    var positionZ = Float()
    var eulerAngle = Float()
    var obliquity = Float()
    init(scale: Float, texture: String, positionX : Float, positionY : Float, positionZ : Float, eulerAngle: Float, obliquity: Float) {
        self.scale = scale
        self.texture = texture
        self.positionX = positionX
        self.positionY = positionY
        self.positionZ = positionZ
        self.eulerAngle =  {
            return FuncionsAuxiliaries.converToRadians(degrees: eulerAngle)
        
        }()
        self.obliquity = {
           return FuncionsAuxiliaries.getVectorAngleObject(degress: obliquity)
        }()
    }
    
  
    
}
