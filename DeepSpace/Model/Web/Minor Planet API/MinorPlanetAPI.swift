//
//  MinorPlanetAPI.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 16/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

struct MinorPlanetAPI : APIManager {
    
    static var baseURL: String = "https://minorplanetcenter.net/web_service/search_orbits?json=1"
    static var key: String?

    // For comet orbits use: https://minorplanetcenter.net/web_service/search_comet_orbits
    
    public static func fetch(_ completion: @escaping ([MinorPlanet]) -> Void) {
        let username = "mpc_ws"
        let password = "mpc!!ws"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()

        GET.request(MinorPlanetAPI.baseURL, authentication: base64LoginString) { data in
            do {
                let minorPlanets = try JSONDecoder().decode([MinorPlanet].self, from: data)
                completion(minorPlanets)
            } catch {
                print("There was a JSON parse error. Error description: \(error.localizedDescription) - \(error)")
            }
        }

    }
    
}
