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
    
    let bestMassJupiterUnits : Double?
    let bestMassEarthUnits : Double?
    
    let radiusJupiterUnits : Double?
    let radiusEarthUnits : Double?
    let radiusSunUnits : Double?
    
    let density : Double?
    let declinationDegrees : Double?
    
    let status : PlanetStatus?
    let yearOfDiscovery : Int?
    let publishDate : String?
    
    let lastUpdated : String?
    
    let hostStar : ExoplanetHostStar?
    
    private enum CodingKeys : String, CodingKey {
        
        case name = "mpl_name"
        case reflink = "mpl_reflink"
        case discoveryMethod = "mpl_discmethod"
        
        case numberOfMoonsInPlanetarySystem = "mpl_mnum"
        case numberOfPlanetsInPlanetarySystem = "mpl_pnum"
        
        case orbitPeriod = "mpl_orbper"
        case timeOfPeriastron = "mpl_orbtper"
        
        case bestMassJupiterUnits = "mpl_bmassj"
        case bestMassEarthUnits = "mpl_bmasse"
        
        case radiusJupiterUnits = "mpl_radj"
        case radiusEarthUnits = "mpl_rade"
        case radiusSunUnits = "mpl_rads"
        
        case density = "mpl_dens"
        case declinationDegrees = "dec"
        
        case status = "mpl_status"
        case yearOfDiscovery = "mpl_disc"
        case publishDate = "mpl_publ_date"
        
        case lastUpdated = "rowupdate"
        
    }
    
    public init(name: String?,
                reflink: String?,
                discoveryMethod: String?,
                numberOfMoonsInPlanetarySystem: Int?,
                numberOfPlanetsInPlanetarySystem: Int?,
                orbitPeriod: Double?,
                timeOfPeriastron: Double?,
                bestMassJupiterUnits: Double?,
                bestMassEarthUnits: Double?,
                radiusJupiterUnits: Double?,
                radiusEarthUnits: Double?,
                radiusSunUnits: Double?,
                density: Double?,
                declinationDegrees: Double?,
                status: PlanetStatus,
                yearOfDiscovery: Int?,
                publishDate: String?,
                lastUpdated: String?,
                hostStar: ExoplanetHostStar?) {
        
        self.name = name
        self.reflink = reflink
        self.discoveryMethod = discoveryMethod
        self.numberOfMoonsInPlanetarySystem = numberOfMoonsInPlanetarySystem
        self.numberOfPlanetsInPlanetarySystem = numberOfPlanetsInPlanetarySystem
        self.orbitPeriod = orbitPeriod
        self.timeOfPeriastron = timeOfPeriastron
        self.bestMassJupiterUnits = bestMassJupiterUnits
        self.bestMassEarthUnits = bestMassEarthUnits
        self.radiusJupiterUnits = radiusJupiterUnits
        self.radiusEarthUnits = radiusEarthUnits
        self.radiusSunUnits = radiusSunUnits
        self.density = density
        self.declinationDegrees = declinationDegrees
        self.status = status
        self.yearOfDiscovery = yearOfDiscovery
        self.publishDate = publishDate
        self.lastUpdated = lastUpdated
        self.hostStar = hostStar
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try? container.decode(String.self, forKey: .name)
        let reflink = try? container.decode(String.self, forKey: .reflink)
        let discoveryMethod = try? container.decode(String.self, forKey: .discoveryMethod)
        let numberOfMoonsInPlanetarySystem = try? container.decode(Int.self, forKey: .numberOfMoonsInPlanetarySystem)
        let numberOfPlanetsInPlanetarySystem = try? container.decode(Int.self, forKey: .numberOfPlanetsInPlanetarySystem)
        let orbitPeriod = try? container.decode(Double.self, forKey: .orbitPeriod)
        let timeOfPeriastron = try? container.decode(Double.self, forKey: .timeOfPeriastron)
        let bestMassJupiterUnits = try? container.decode(Double.self, forKey: .bestMassJupiterUnits)
        let bestMassEarthUnits = try? container.decode(Double.self, forKey: .bestMassEarthUnits)
        let radiusJupiterUnits = try? container.decode(Double.self, forKey: .radiusJupiterUnits)
        let radiusEarthUnits = try? container.decode(Double.self, forKey: .radiusEarthUnits)
        let radiusSunUnits = try? container.decode(Double.self, forKey: .radiusSunUnits)
        let density = try? container.decode(Double.self, forKey: .density)
        let declinationDegrees = try? container.decode(Double.self, forKey: .declinationDegrees)
        let status = try container.decode(PlanetStatus.self, forKey: .status)
        let yearOfDiscovery = try? container.decode(Int.self, forKey: .yearOfDiscovery)
        let publishDate = try? container.decode(String.self, forKey: .publishDate)
        let lastUpdated = try? container.decode(String.self, forKey: .lastUpdated)
        let hostStar = try? ExoplanetHostStar(from: decoder)
        
        self.init(name: name,
                  reflink: reflink,
                  discoveryMethod: discoveryMethod,
                  numberOfMoonsInPlanetarySystem: numberOfMoonsInPlanetarySystem,
                  numberOfPlanetsInPlanetarySystem: numberOfPlanetsInPlanetarySystem,
                  orbitPeriod: orbitPeriod,
                  timeOfPeriastron: timeOfPeriastron,
                  bestMassJupiterUnits: bestMassJupiterUnits,
                  bestMassEarthUnits: bestMassEarthUnits,
                  radiusJupiterUnits: radiusJupiterUnits,
                  radiusEarthUnits: radiusEarthUnits,
                  radiusSunUnits: radiusSunUnits,
                  density: density,
                  declinationDegrees: declinationDegrees,
                  status: status,
                  yearOfDiscovery: yearOfDiscovery,
                  publishDate: publishDate,
                  lastUpdated: lastUpdated,
                  hostStar: hostStar)
    }
    
}
