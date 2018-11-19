//
//  MinorPlanet.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 16/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

/// All bodies, excluding comets, which are not planets or natural satellites (can be Dwarf planets, Asteroids, Centaurs, Trojans, Kuiper belt objects and other trans-Neptunian objects)
struct MinorPlanet : Codable {
    
    /// H, apparent magnitude the asteroid would have if it were observed from 1 AU away at zero phase, while it was 1 AU away from the Sun. Note this is geometrically impossible and is equivalent to observing the asteroid from the center of the Sun.
    let absoluteMagnitude : String?
    
    /// The distance when the asteroid is furthest from the Sun in its orbit.
    let aphelionDistance : String?
    
    /// ω, defines the orientation of the ellipse in the orbital plane and is the angle from the asteroid's ascending node to its perihelion, measured in the direction of motion. Range: 0–360°.
    let argumentOfPerihelion : String?
    
    /// Ω, the longitude of the ascending node, it defines the horizontal orientation of the ellipse with respect to the ecliptic, and is the angle measured counterclockwise (as seen from North of the ecliptic) from the First Point of Aries to the ascending node. Range: 0–360°.
    let ascendingNode : String?
    
    /// Δv, an estimate of the amount of energy necessary to jump from LEO (Low Earth Orbit) to the asteroid's orbit.
    let deltaV : Float?
    
    /// Minimum Orbit Intersection Distance with respect to Earth.
    let earthMoid : Float?
    
    /// e, a measure of how far the orbit shape departs from a circle. Range: 0–1, with e = 0 being a perfect circle, intermediate values being ellipses ever more elongated as eincreases, and e = 1 describing a parabola.
    let eccentricity : String?
    
    /// The date/time of reference for the current orbital parameters.
    let epoch : String?
    
    /// The Julian Date of the epoch.
    let epochJd : String?
    
    /// i, the angle between the asteroid's orbit and the ecliptic. Range: 0–180°.
    let inclination : String?
    
    /// Minimum Orbit Intersection Distance with respect to Jupiter.
    let jupiterMoid : Float?
    
    /// Flag - NEOs larger than ~1 km in diameter.
    let kmNeo : Bool?
    
    /// Minimum Orbit Intersection Distance with respect to Mars.
    let marsMoid : Float?
    
    /// M, is related to the position of the asteroid along its orbit at the given epoch. Range: 0–360°.
    let meanAnomaly : String?
    
    /// n, a measure of the average speed of the asteroid along its orbit.
    let meanDailyMotion : String?
    
    /// Minimum Orbit Intersection Distance with respect to Mercury.
    let mercuryMoid : Float?
    
    /// The asteroid's name.
    let name : String?
    
    /// Flag - Near Earth Objects (NEOs).
    let neo : Bool?
    
    /// The asteroid's number.
    let number : Int?
    
    /// The minor planet's orbit type
    let orbitType : OrbitType?
    
    /// Date when the asteroid is at perihelion, i.e., reaches its closest point to the Sun.
    let perihelionDate : String?
    
    /// The Julian Date of perihelion.
    let perihelionDateJd : String?
    
    /// The distance when the asteroid is nearest to the Sun in its orbit.
    let perihelionDistance : String?
    
    /// Time it takes for the asteroid to complete one orbit around the Sun.
    let period : String?
    
    /// Flag Potentially Hazardous Asteroids (PHAs).
    let pha : Bool?
    
    /// G, slope parameter as calculated or assumed by the MPC. The slope parameter is a measure of how much brighter the asteroid gets as its phase angle decreases. When not known, a value of G = 0.15 is assumed.
    let phaseSlope : String?
    
    /// Minimum Orbit Intersection Distance with respect to Saturn.
    let saturnMoid : Float?
    
    /// a, one half of the longest diameter of the orbital ellipse.
    let semimajorAxis : String?
    
    /// TJ, Tisserand parameter with respect to Jupiter, which is a quasi-invariant value for each asteroid and is frequently used to distinguish asteroids (typically TJ > 3) from Jupiter-family comets (typically 2 < TJ < 3).
    let tisserandJupiter : Float?
    
    /// Last planet update.
    let updatedAt : String?
    
    /// Minimum Orbit Intersection Distance with respect to Uranus.
    let uranusMoid : Float?
    
    /// Minimum Orbit Intersection Distance with respect to Venus.
    let venusMoid : Float?
    
    enum CodingKeys: String, CodingKey {
        case absoluteMagnitude = "absolute_magnitude"
        case aphelionDistance = "aphelion_distance"
        case argumentOfPerihelion = "argument_of_perihelion"
        case ascendingNode = "ascending_node"
        case deltaV = "delta_v"
        case earthMoid = "earth_moid"
        case eccentricity = "eccentricity"
        case epoch = "epoch"
        case epochJd = "epoch_jd"
        case inclination = "inclination"
        case jupiterMoid = "jupiter_moid"
        case kmNeo = "km_neo"
        case marsMoid = "mars_moid"
        case meanAnomaly = "mean_anomaly"
        case meanDailyMotion = "mean_daily_motion"
        case mercuryMoid = "mercury_moid"
        case name = "name"
        case neo = "neo"
        case number = "number"
        case orbitType = "orbit_type"
        case perihelionDate = "perihelion_date"
        case perihelionDateJd = "perihelion_date_jd"
        case perihelionDistance = "perihelion_distance"
        case period = "period"
        case pha = "pha"
        case phaseSlope = "phase_slope"
        case saturnMoid = "saturn_moid"
        case semimajorAxis = "semimajor_axis"
        case tisserandJupiter = "tisserand_jupiter"
        case updatedAt = "updated_at"
        case uranusMoid = "uranus_moid"
        case venusMoid = "venus_moid"
    }
        
}
