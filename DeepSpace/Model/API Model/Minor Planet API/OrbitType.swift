//
//  OrbitType.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 19/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

/// Asteroids are classified from a dynamics perspective by the area of the Solar System in which they orbit. A number identifies each orbit type.
///
/// - unclassified: 0
/// - atiras: 1
/// - atens: 2
/// - apollos: 3
/// - amors: 4
/// - marsCrossers: 5
/// - hungarias: 6
/// - phocaeas: 7
/// - hildas: 8
/// - jupiterTrojans: 9
/// - distantObjects: 10
public enum OrbitType : Int, Codable {
    case unclassified = 0
    case atiras = 1
    case atens = 2
    case apollos = 3
    case amors = 4
    case marsCrossers = 5
    case hungarias = 6
    case phocaeas = 7
    case hildas = 8
    case jupiterTrojans = 9
    case distantObjects = 10
}
