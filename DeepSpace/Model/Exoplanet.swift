//
//  Exoplanet.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on November 13, 2018

import Foundation

struct Exoplanet : Codable {
    
    let name : String?
    let reflink : String?
    let discoveryMethod : String?
    
    let numberOfMoonsInPlanetarySystem : Int?
    let numberOfPlanetsInPlanetarySystem : Int?
    
    let orbitPeriod : Double?
    let timeOfPeriastron : Double?
    
    let massSunUnits : Double?
    let bestMassJupiterUnits : Double?
    let bestMassEarthUnits : Double?
    
    let radius : Double?
    let radiusJupiterUnits : Double?
    let radiusEarthUnits : Double?
    let radiusSunUnits : Double?
    
    let density : Double?
    let declinationDegrees : Double?
    let effectiveTemperatureKelvin : Double?
    
    let status : PlanetStatus?
    let yearOfDiscovery : Int?
    let publishDate : String?
    
    let lastUpdated : String?
    
    private enum CodingKeys : String, CodingKey {
        case name = "mpl_name"
        case reflink = "mpl_reflink"
        case discoveryMethod = "mpl_discmethod"
        
        case numberOfMoonsInPlanetarySystem = "mpl_mnum"
        case numberOfPlanetsInPlanetarySystem = "mpl_pnum"
        
        case orbitPeriod = "mpl_orbper"
        case timeOfPeriastron = "mpl_orbtper"
        
        case massSunUnits = "mst_mass"
        case bestMassJupiterUnits = "mpl_bmassj"
        case bestMassEarthUnits = "mpl_bmasse"
        
        case radius = "mst_rad"
        case radiusJupiterUnits = "mpl_radj"
        case radiusEarthUnits = "mpl_rade"
        case radiusSunUnits = "mpl_rads"
        
        case density = "mpl_dens"
        case declinationDegrees = "dec"
        case effectiveTemperatureKelvin = "mst_teff"
        
        case status = "mpl_status"
        case yearOfDiscovery = "mpl_disc"
        case publishDate = "mpl_publ_date"
        
        case lastUpdated = "rowupdate"
    }
    
}
