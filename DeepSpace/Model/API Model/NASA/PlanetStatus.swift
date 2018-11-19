//
//  PlanetStatus.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 14/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

/// Status of the planet (1 = announced, 2 = submitted, 3 = accepted, 0 = retracted).
public enum PlanetStatus : Int, Codable {
    case retracted = 0
    case announced = 1
    case submitted = 2
    case accepted = 3
}
