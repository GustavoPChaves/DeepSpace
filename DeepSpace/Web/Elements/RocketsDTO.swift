//
//  RocketsDTO.swift
//  DeepSpace
//
//  Created by Adriel Freire on 13/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

struct RocketsDTO: Codable {
    var id: Int
    var active: Bool
    var stages: Int
    var height: Height
    var flickr_images: [String]
    
}

struct Height: Codable{
    var meters: Double
    var feet: Double
}
