//
//  SpaceXAPIManager.swift
//  DeepSpace
//
//  Created by Adriel Freire on 12/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
class SpaceXAPIManager: APIManager {
    
    static var baseURL: String = "https://api.spacexdata.com/v3/"
    static var key: String?
    
    static func requestDragons(_ completion: @escaping ([DragonDTO]) -> Void) {
        let url = SpaceXAPIManager.baseURL + "dragons"
        GET.request(url) { data in
            do{
                let dragons = try JSONDecoder().decode([DragonDTO].self, from: data)
                completion(dragons)
            } catch {
                print("There was a JSON parse error. Error description: \(error.localizedDescription)")
            }
        }

    }
    
    static func requestRockets(_ completion: @escaping ([RocketsDTO]) -> Void) {
        let url = SpaceXAPIManager.baseURL + "rockets"
        GET.request(url) { data in
            do{
                let rockets = try JSONDecoder().decode([RocketsDTO].self, from: data)
                completion(rockets)
            } catch {
                print("There was a JSON parse error. Error description: \(error.localizedDescription)")
            }
        }
        
    }
    
    static func requestRoadster(_ completion: @escaping (RoadsterDTO) -> Void) {
        let url = SpaceXAPIManager.baseURL + "roadster"
        GET.request(url) { (data) -> (Void) in
            do{
                let roadster = try JSONDecoder().decode(RoadsterDTO.self, from: data)
                completion(roadster)
                
            } catch {
                print("There was a JSON parse error. Error description: \(error.localizedDescription)")
            }
        }
    }
  
    
}
