//
//  FuncionsAuxiliaries.swift
//  DeepSpace
//
//  Created by João batista Romão on 21/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
class FuncionsAuxiliaries {
    static func converToRadians(degrees: Float) -> Float {
        let radiansValue = degrees * (.pi/180)
        return radiansValue
    }
    
    static func getVectorAngleObject(degress: Float) -> Float {
        //Corrigir formula pra uranus
        if degress != 0{
            let angleDegress = cos(degress)*10
            return angleDegress
        }
        return 0.0
    }
    static func getNameAlltextures(nameObject: String) -> [String] {
        //rename let texture for name origin scnkit
        var textures = [String]()
        let difusse = nameObject
        let ambient = "\(nameObject)+ambient"
        let displacemente =  "\(nameObject)+displacement"
        let normal =  "\(nameObject)+normal"
        let specular =  "\(nameObject)+specular"
        textures.append(contentsOf: [difusse,ambient,displacemente,normal,specular])
        return textures
    }
}
