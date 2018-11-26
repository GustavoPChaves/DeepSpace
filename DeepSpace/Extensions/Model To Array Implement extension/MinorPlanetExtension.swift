//
//  MinorPlanetExtension.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 25/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

extension MinorPlanet : ConvertibleToArray {
    func toArray() -> [(property: String, value: String)] {
        let name = (property: "Name", value: self.name!)
        let number = (property: "Number", value: "\(self.number!)")
        
        let aphelionDistance = (property: "Aphelion distance", value: "\(self.aphelionDistance!)")
        let perihelionDist = (property: "Perihelion distance", value: "\(self.perihelionDistance!)")
        let perihelionDate = (property: "Perihelion date", value: "\(self.perihelionDate!)")
        let perihelionDateJd = (property: "Perihelion date (in Julian Days)", value: "\(self.perihelionDateJd!)")
        
        let absoluteMag = (property: "Absolute magnitude", value: "\(self.absoluteMagnitude!)")
        
        let orbitalPeriod = (property: "Orbital period", value: "\(self.period!)")
        let orbitVeloAvg = (property: "Average orbital speed", value: "\(self.meanDailyMotion!)")
        let orbitType = (property: "Orbit type", value: "\(OrbitType.toString(orbitType: self.orbitType!))")
        
        var eccValue = ""
        switch self.eccentricity! {
        case "0":
            eccValue = "Perfect circle"
        case "1":
            eccValue = "Parabola"
        default:
            eccValue = "Ellipse"
        }
        
        let eccentricity = (property: "Eccentricity (Orbit shape)", value: eccValue)
        let semimajorAxis = (property: "Semimajor axis", value: "\(self.semimajorAxis!)")
        let orbitPos = (property: "Orbital position at epoch", value: "\(self.meanAnomaly!)º")
        
        let epoch = (property: "Epoch", value: "\(self.epoch!)")
        let epochJd = (property: "Epoch (in Julian Days)", value: "\(self.epochJd!)")
        
        let inclination = (property: "Inclination", value: "\(self.inclination!)")
        let kmNeo = (property: "Larger than 1 km in diameter", value: "\(self.kmNeo! ? "Yes" : "No")")
        let isNeo = (property: "Near to Earth (is a NEO object)", value: "\(self.neo! ? "Yes" : "No")")
        let isPha = (property: "Is a PHA (Potentially Hazardous Asteroid)", value: "\(self.pha! ? "Yes" : "No")")
        let tj = (property: "Tisserand Jupiter", value: "\(self.tisserandJupiter!)")
        
        let mercMOID = (property: "Mercury MOID", value: "\(self.mercuryMoid!)")
        let venusMOID = (property: "Venus MOID", value: "\(self.venusMoid!)")
        let earthMOID = (property: "Earth MOID", value: "\(self.earthMoid!)")
        let marsMOID = (property: "Mars MOID", value: "\(self.marsMoid!)")
        let jupiterMOID = (property: "Jupiter MOID", value: "\(self.jupiterMoid!)")
        let saturnMOID = (property: "Saturn MOID", value: "\(self.saturnMoid!)")
        let uranusMOID = (property: "Uranus MOID", value: "\(self.uranusMoid!)")
        
        let lastUpdated = (property: "Last updated", value: "\(self.updatedAt!)")
        
        return [name, number,
                aphelionDistance, perihelionDist, perihelionDate, perihelionDateJd,
                absoluteMag,
                orbitalPeriod, orbitVeloAvg, orbitType, eccentricity, semimajorAxis, orbitPos,
                epoch, epochJd,
                inclination, kmNeo, isNeo, isPha, tj,
                mercMOID, venusMOID, earthMOID, marsMOID, jupiterMOID, saturnMOID, uranusMOID,
                lastUpdated]
    }
}
