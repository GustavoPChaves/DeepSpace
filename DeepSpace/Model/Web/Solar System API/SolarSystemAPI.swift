//
//  SolarSystemAPI.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 17/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

struct SolarSystemAPI : APIManager {
    
    static var baseURL: String = "https://dry-plains-91502.herokuapp.com/planets"
    static var key: String?
    
    public static func fetch(_ completion: @escaping ([SolarSystemPlanet]) -> Void) {
        GET.request(SolarSystemAPI.baseURL) { data in
            do {
                let planets = try JSONDecoder().decode([SolarSystemPlanet].self, from: data)
                completion(planets)
            } catch {
                print("There was a JSON parse error. Error description: \(error.localizedDescription) - \(error)")
            }
        }
    }
    
    public static func getBody(_ body: SolarSystemBodies, _ completion: @escaping (SolarSystemPlanet) -> Void) {
        GET.request(SolarSystemAPI.baseURL + body.rawValue) { data in
            do {
                let planets = try JSONDecoder().decode(SolarSystemPlanet.self, from: data)
                completion(planets)
            } catch {
                print("There was a JSON parse error. Error description: \(error.localizedDescription) - \(error)")
            }
        }
    }
    
}
