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
        var array : [(String,String)] = []
        
        var name = (property: "Name", value: "")
        if self.name != nil {
            name.value = self.name!
        } else {
            name.value = "No info available"
        }
        array.append(name)
        
        var reflink = (property: "Link", value: "")
        if self.reflink != nil {
            let formattedReflink = self.reflink!.replacingOccurrences(of: "<a refstr=LIVINGSTON_ET_AL__2018 href=", with: "").replacingOccurrences(of: " target=ref>Livingston et al. 2018</a>", with: "")
            reflink.value = formattedReflink
        } else {
            reflink.value = "No info available"
        }
        array.append(reflink)
        
        var discMethod = (property: "Discovery method", value: "")
        if self.discoveryMethod != nil {
            discMethod.value = self.discoveryMethod!
        } else {
            discMethod.value = "No info available"
        }
        array.append(discMethod)
        
        var numMoons = (property: "Number of moons in the planetary system", value: "")
        if self.numberOfMoonsInPlanetarySystem != nil {
            numMoons.value = "\(self.numberOfMoonsInPlanetarySystem!)"
        } else {
            numMoons.value = "No info available"
        }
        array.append(numMoons)
        
        var numPlanets = (property: "Number of planets in the planetary system", value: "")
        if self.numberOfPlanetsInPlanetarySystem != nil
        && self.numberOfPlanetsInPlanetarySystem! > 0 {
            numPlanets.value = "\(self.numberOfMoonsInPlanetarySystem!)"
        } else {
            numPlanets.value = "No info available"
        }
        array.append(numPlanets)
        
        var orbitPeriod = (property: "Orbital period", value: "")
        if self.orbitPeriod != nil {
            orbitPeriod.value = "\(self.orbitPeriod!)"
        } else {
            orbitPeriod.value = "No info available"
        }
        array.append(orbitPeriod)
        
        var periastron = (property: "Time of periastron", value: "")
        if self.timeOfPeriastron != nil {
            periastron.value = "\(self.timeOfPeriastron!)"
        } else {
            periastron.value = "No info available"
        }
        array.append(periastron)

        var massJ = (property: "Mass (in Jupiter Units)", value: "")
        if self.bestMassJupiterUnits != nil {
            massJ.value = "\(self.bestMassJupiterUnits!)"
        } else {
            massJ.value = "No info available"
        }
        array.append(massJ)
        
        var massE = (property: "Mass (in Earth Units)", value: "")
        if self.bestMassEarthUnits != nil {
            massE.value = "\(self.bestMassEarthUnits!)"
        } else {
            massE.value = "No info available"
        }
        array.append(massE)
        
        var radiusJ = (property: "Radius (in Jupiter Units)", value: "")
        if self.radiusJupiterUnits != nil {
            radiusJ.value = "\(self.radiusJupiterUnits!)"
        } else {
            radiusJ.value = "No info available"
        }
        array.append(radiusJ)
        
        var radiusE = (property: "Radius (in Earth Units)", value: "")
        if self.radiusEarthUnits != nil {
            radiusE.value = "\(self.radiusEarthUnits!)"
        } else {
            radiusE.value = "No info available"
        }
        array.append(radiusE)
        
        var radiusS = (property: "Radius (in Sun Units)", value: "")
        if self.radiusSunUnits != nil {
            radiusS.value = "\(self.radiusSunUnits!)"
        } else {
            radiusS.value = "No info available"
        }
        array.append(radiusS)
        
        var density = (property: "Density", value: "")
        if self.density != nil {
            density.value = "\(self.density!) x g/cmˆ3"
        } else {
            density.value = "No info available"
        }
        array.append(density)
        
        var declination = (property: "Declination", value: "")
        if self.declinationDegrees != nil {
            declination.value = "\(self.orbitPeriod!)º"
        } else {
            declination.value = "No info available"
        }
        array.append(declination)
        
        var status = (property: "Planet status", value: "")
        if self.status != nil {
            status.value = "\(PlanetStatus.toString(status: self.status!))"
        } else {
            status.value = "No info available"
        }
        array.append(status)
        
        var yearOfDiscovery = (property: "Year of discovery", value: "")
        if self.yearOfDiscovery != nil {
            yearOfDiscovery.value = "\(self.yearOfDiscovery!)"
        } else {
            yearOfDiscovery.value = "No info available"
        }
        array.append(yearOfDiscovery)
        
        var publishDate = (property: "Publish date", value: "")
        if self.publishDate != nil {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM"
            
            let date = df.date(from: self.publishDate!)
            df.dateFormat = "MM/yyyy"
            
            let dateString = df.string(from: date!)
            publishDate.value = "\(dateString)"
            
        } else {
            publishDate.value = "No info available"
        }
        array.append(publishDate)
        
        var lastUpdated = (property: "Last updated", value: "")
        if self.lastUpdated != nil {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            
            let date = df.date(from: self.lastUpdated!)
            df.dateFormat = "MM/dd/yyyy"
            
            let dateString = df.string(from: date!)
            lastUpdated.value = "\(dateString)"
            
        } else {
            lastUpdated.value = "No info available"
        }
        array.append(lastUpdated)
        
        var hostStar = [(String,String)]()
        if self.hostStar != nil {
            hostStar = self.hostStar!.toArray()
            array.append(contentsOf: hostStar)
        } else {
            array.append((property: "Host star", value: "No info available"))
        }
        
        return array
    }
    
}
