//
//  root.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 17/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

struct SolarSystemPlanet : Codable {
    
    let createdAt : String?
    let density : Int?
    let diameter : Int?
    let distanceFromSun : String?
    let gravity : String?
    let id : Int?
    let lengthOfDay : String?
    let mass : String?
    let meanTemperature : Int?
    let name : String?
    let numberOfMoons : Int?
    let orbitalPeriod : String?
    let orbitalVelocity : String?
    let rotationPeriod : String?
    let updatedAt : String?
    var solarSystemBody : SolarSystemBodies? = nil
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case density = "density"
        case diameter = "diameter"
        case distanceFromSun = "distance_from_sun"
        case gravity = "gravity"
        case id = "id"
        case lengthOfDay = "length_of_day"
        case mass = "mass"
        case meanTemperature = "mean_temperature"
        case name = "name"
        case numberOfMoons = "number_of_moons"
        case orbitalPeriod = "orbital_period"
        case orbitalVelocity = "orbital_velocity"
        case rotationPeriod = "rotation_period"
        case updatedAt = "updated_at"
    }
    
}
