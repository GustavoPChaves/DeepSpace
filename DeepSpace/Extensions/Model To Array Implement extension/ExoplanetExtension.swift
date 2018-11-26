//
//  ExoplanetExtension.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 25/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

extension Exoplanet : ConvertibleToArray {
    func toArray() -> [(property: String, value: String)] {
        let name = (property: "Name", value: "\(self.name ?? "No info available")")
        let reflink = (property: "Link", value: "\(self.reflink ?? "No info available")")
        let discoveryMethod = (property: "Discovery method", value: "\(self.discoveryMethod ?? "No info available")")
        
//        let numMoons = (property: "Number of moons in the planetary system", value: "\(self.numberOfMoonsInPlanetarySystem)")
//        let numPlanets = (property: "Number of planets in planetary system", value: "\(self.numberOfPlanetsInPlanetarySystem!)")
//
//        let orbitPeriod = (property: "Orbital period", value: "\(self.orbitPeriod!)")
//        let periastron = (property: "Time of periastron", value: "\(self.timeOfPeriastron!)")
//
//        let massJ = (property: "Mass (in Jupiter Units)", value: "\(self.bestMassJupiterUnits!)")
//        let massE = (property: "Mass (in Earth Units)", value: "\(self.bestMassEarthUnits!)")
//
//        let radiusJ = (property: "Radius (in Jupiter Units)", value: "\(self.radiusJupiterUnits!)")
//        let radiusE = (property: "Radius (in Earth Units)", value: "\(self.radiusEarthUnits!)")
//        let radiusS = (property: "Radius (in Sun Units)", value: "\(self.radiusSunUnits!)")
//
//        let density = (property: "Density", value: "\(self.density!)")
//        let declination = (property: "Declination", value: "\(self.declinationDegrees!)")
        
        let status = (property: "Planet status", value: "\(PlanetStatus.toString(status: self.status!))")
        let yearOfDiscovery = (property: "Year of discovery", value: "\(self.yearOfDiscovery!)")
//        let publishDate = (property: "Publish date", value: "\(self.publishDate!)")
        
        let lastUpdated = (property: "Last updated", value: "\(self.lastUpdated!)")
        
//        let hostStar : ExoplanetHostStar?
        
//        return [name, reflink, discoveryMethod, numMoons, numPlanets, orbitPeriod, periastron, massJ, massE, radiusJ, radiusE, radiusS, density, declination, status, yearOfDiscovery, publishDate, lastUpdated]
        return [name, reflink, discoveryMethod, status, yearOfDiscovery, lastUpdated]
    }
    
}
