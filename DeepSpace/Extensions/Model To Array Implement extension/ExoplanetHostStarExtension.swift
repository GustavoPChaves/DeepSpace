//
//  ExoplanetHostStarExtension.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 26/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

extension ExoplanetHostStar : ConvertibleToArray {
    func toArray() -> [(property: String, value: String)] {
        var array: [(String,String)] = []
        
        var henryDraperCatalogName = (property: "Host star name (in Henry Draper Catalog)", value: "")
        if self.henryDraperCatalogName != nil {
            henryDraperCatalogName.value = self.henryDraperCatalogName!
        } else {
            henryDraperCatalogName.value = "No info available"
        }
        array.append(henryDraperCatalogName)
        
        var hipparcosCatalogName = (property: "Host star name (in Hipparcos Catalog)", value: "")
        if self.hipparcosCatalogName != nil {
            hipparcosCatalogName.value = self.hipparcosCatalogName!
        } else {
            hipparcosCatalogName.value = "No info available"
        }
        array.append(hipparcosCatalogName)
        
        var age = (property: "Host star age", value: "")
        if self.age != nil {
            age.value = "\(self.age!)"
        } else {
            age.value = "No info available"
        }
        array.append(age)
        
        var massSunUnits = (property: "Host star mass (in Sun Units)", value: "")
        if self.massSunUnits != nil {
            massSunUnits.value = "\(self.massSunUnits!)"
        } else {
            massSunUnits.value = "No info available"
        }
        array.append(massSunUnits)
        
        var radiusSunUnits = (property: "Host star radius (in Sun Units)", value: "")
        if self.radiusSunUnits != nil {
            radiusSunUnits.value = "\(self.radiusSunUnits!)"
        } else {
            radiusSunUnits.value = "No info available"
        }
        array.append(radiusSunUnits)
        
        var gravitation = (property: "Host star gravitation", value: "")
        if self.gravitation != nil {
            gravitation.value = "\(self.gravitation!)"
        } else {
            gravitation.value = "No info available"
        }
        array.append(gravitation)
        
        var luminositySunUnits = (property: "Host star luminosity (in Sun Units)", value: "")
        if self.luminositySunUnits != nil {
            luminositySunUnits.value = "\(self.luminositySunUnits!)"
        } else {
            luminositySunUnits.value = "No info available"
        }
        array.append(luminositySunUnits)
        
        var density = (property: "Host star density", value: "")
        if self.density != nil {
            density.value = "\(self.density!)"
        } else {
            density.value = "No info available"
        }
        array.append(density)
        
        var effectiveTemperatureKelvin = (property: "Host star effective temperature", value: "")
        if self.effectiveTemperatureKelvin != nil {
            effectiveTemperatureKelvin.value = "\(self.effectiveTemperatureKelvin!) K"
        } else {
            effectiveTemperatureKelvin.value = "No info available"
        }
        array.append(effectiveTemperatureKelvin)
        
        var metallicityRatio = (property: "Host star metallicity ratio", value: "")
        if self.metallicityRatio != nil {
            metallicityRatio.value = "\(self.metallicityRatio!)"
        } else {
            metallicityRatio.value = "No info available"
        }
        array.append(metallicityRatio)
        
        var metallicity = (property: "Host star metallicity", value: "")
        if self.metallicity != nil {
            metallicity.value = "\(self.metallicity!)"
        } else {
            metallicity.value = "No info available"
        }
        array.append(metallicity)
        
        return array
    }
}
