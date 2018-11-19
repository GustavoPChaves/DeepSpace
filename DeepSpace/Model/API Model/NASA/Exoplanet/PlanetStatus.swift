//
//  PlanetStatus.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 14/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

/// Status of the planet
///
/// - retracted: 0
/// - announced: 1
/// - submitted: 2
/// - accepted: 3
public enum PlanetStatus : Int, Codable {
    case retracted = 0
    case announced = 1
    case submitted = 2
    case accepted = 3
}
