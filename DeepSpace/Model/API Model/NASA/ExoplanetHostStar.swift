//
//  ExoplanetHostStar.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 14/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

struct ExoplanetHostStar : Codable {
    
    let henryDraperCatalogName : String?
    let hipparcosCatalogName : String?
    let age : Double?
    
    let massSunUnits : Double?
    let radiusSunUnits : Double?
    let gravitation : Double?
    let luminositySunUnits : Double?
    let density : Double?
    let effectiveTemperatureKelvin : Double?
    
    /// Measurement of the metal content of the photosphere of the star as compared to the hydrogen content.
    let metallicity : Double?
    
    /// Ratio for the Metallicity Value ([Fe/H] denotes iron abundance, [M/H] refers to a general metal content)
    let metallicityRatio : String?
    
    private enum CodingKeys : String, CodingKey {
        case henryDraperCatalogName = "hd_name"
        case hipparcosCatalogName = "hip_name"
        case age = "mst_age"
        
        case massSunUnits = "mst_mass"
        case radiusSunUnits = "mst_rad"
        case gravitation = "mst_logg"
        case luminositySunUnits = "mst_lum"
        case density = "mst_dens"
        case effectiveTemperatureKelvin = "mst_teff"
        
        case metallicity = "mst_metfe"
        case metallicityRatio = "mst_metratio"
    }
    
}
