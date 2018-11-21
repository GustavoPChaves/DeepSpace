//
//  SolarSystemselfExtension.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 20/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

extension SolarSystemPlanet {
    public func toArray() -> [(property: String, value: String)] {
        let nameProperty = (property: "Name", value: self.name!)
        let diameterProperty = (property: "Diameter", value: "\(self.diameter!) x 10ˆ3 km")
        let sunDistanceProperty = (property: "Distance from the Sun", value: "\(self.distanceFromSun!) x 10ˆ6 km")
        let lenghtOfDayProperty = (property: "Length of a day", value: "\(self.lengthOfDay!)h")
        let numberMoonsProperty = (property: "Number of Moons", value: "\(self.numberOfMoons!)")
        
        var orbitalPeriodProperty = (property: "Orbital period", value: "")
        
        if (self.solarSystemBody! == .saturn)
            || (self.solarSystemBody! == .neptune)
            || (self.solarSystemBody! == .uranus)
            || (self.solarSystemBody! == .pluto) {
            orbitalPeriodProperty.value = "\(self.orbitalPeriod!) x 10ˆ3 days"
        } else {
            orbitalPeriodProperty.value = "\(self.orbitalPeriod!) days"
        }
        
        let orbitalVelocityProperty = (property: "Orbital velocity", value: "\(self.orbitalVelocity!) km/s")
        let rotationPeriodProperty = (property: "Rotation period", value: "\(self.rotationPeriod!.replacingOccurrences(of: "-", with: ""))h")
        let gravityProperty = (property: "Gravity", value: "\(self.gravity!) m/sˆ2")
        let densityProperty = (property: "Density", value: "\(self.density!) g/cmˆ3")
        let massProperty = (property: "Mass", value: "\(self.mass!) x 10ˆ24 kg")
        let meanTempProperty = (property: "Mean temperature", value: "\(self.meanTemperature!) ºC")
        let updatedProperty = (property: "Last updated at", value: self.updatedAt!)
        
        return [nameProperty, diameterProperty, sunDistanceProperty, lenghtOfDayProperty, numberMoonsProperty, orbitalPeriodProperty, orbitalVelocityProperty, rotationPeriodProperty, gravityProperty, densityProperty, massProperty, meanTempProperty, updatedProperty]
    }
}
