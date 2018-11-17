//
//  MinorPlanet.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 16/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

struct MinorPlanet : Codable {
    
    let absoluteMagnitude : String?
    let aphelionDistance : String?
    let arcLength : Int?
    let argumentOfPerihelion : String?
    let ascendingNode : String?
    let criticalListNumberedObject : Bool?
    let deltaV : Float?
    let designation : Int?
    let earthMoid : Float?
    let eccentricity : String?
    let epoch : String?
    let epochJd : String?
    let firstObservationDateUsed : String?
    let firstOppositionUsed : String?
    let inclination : String?
    let jupiterMoid : Float?
    let kmNeo : Bool?
    let lastObservationDateUsed : String?
    let lastOppositionUsed : String?
    let marsMoid : Float?
    let meanAnomaly : String?
    let meanDailyMotion : String?
    let mercuryMoid : Float?
    let name : String?
    let neo : Bool?
    let number : Int?
    let observations : Int?
    let oppositions : Int?
    let orbitType : Int?
    let orbitUncertainty : String?
    let pVectorX : String?
    let pVectorY : String?
    let pVectorZ : String?
    let perihelionDate : String?
    let perihelionDateJd : String?
    let perihelionDistance : String?
    let period : String?
    let pha : Bool?
    let phaseSlope : String?
    let qVectorX : String?
    let qVectorY : String?
    let qVectorZ : String?
    let residualRms : String?
    let saturnMoid : Float?
    let semimajorAxis : String?
    let tisserandJupiter : Float?
    let updatedAt : String?
    let uranusMoid : Float?
    let venusMoid : Float?
    
    enum CodingKeys: String, CodingKey {
        case absoluteMagnitude = "absolute_magnitude"
        case aphelionDistance = "aphelion_distance"
        case arcLength = "arc_length"
        case argumentOfPerihelion = "argument_of_perihelion"
        case ascendingNode = "ascending_node"
        case criticalListNumberedObject = "critical_list_numbered_object"
        case deltaV = "delta_v"
        case designation = "designation"
        case earthMoid = "earth_moid"
        case eccentricity = "eccentricity"
        case epoch = "epoch"
        case epochJd = "epoch_jd"
        case firstObservationDateUsed = "first_observation_date_used"
        case firstOppositionUsed = "first_opposition_used"
        case inclination = "inclination"
        case jupiterMoid = "jupiter_moid"
        case kmNeo = "km_neo"
        case lastObservationDateUsed = "last_observation_date_used"
        case lastOppositionUsed = "last_opposition_used"
        case marsMoid = "mars_moid"
        case meanAnomaly = "mean_anomaly"
        case meanDailyMotion = "mean_daily_motion"
        case mercuryMoid = "mercury_moid"
        case name = "name"
        case neo = "neo"
        case number = "number"
        case observations = "observations"
        case oppositions = "oppositions"
        case orbitType = "orbit_type"
        case orbitUncertainty = "orbit_uncertainty"
        case pVectorX = "p_vector_x"
        case pVectorY = "p_vector_y"
        case pVectorZ = "p_vector_z"
        case perihelionDate = "perihelion_date"
        case perihelionDateJd = "perihelion_date_jd"
        case perihelionDistance = "perihelion_distance"
        case period = "period"
        case pha = "pha"
        case phaseSlope = "phase_slope"
        case qVectorX = "q_vector_x"
        case qVectorY = "q_vector_y"
        case qVectorZ = "q_vector_z"
        case residualRms = "residual_rms"
        case saturnMoid = "saturn_moid"
        case semimajorAxis = "semimajor_axis"
        case tisserandJupiter = "tisserand_jupiter"
        case updatedAt = "updated_at"
        case uranusMoid = "uranus_moid"
        case venusMoid = "venus_moid"
    }
        
}
