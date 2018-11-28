//
//  SpaceXAPIManager.swift
//  DeepSpace
//
//  Created by Adriel Freire on 12/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
class SpaceXAPIManager {
    typealias element = elements
    

    enum elements: String {
        case dragons
        case rockets
        case roadster
        
    }
    
    
    
    var baseURL: String = "https://api.spacexdata.com/v3/"
    var key: String?
    
  
    
    
    func requestDragons() {
        
        let url = self.baseURL+"dragons"
        GET.request(url) { (data) -> (Void) in
            do{
                let mystruct:[DragonDTO] = try JSONDecoder().decode([DragonDTO].self, from: data)
                print(mystruct)

            } catch{
               print(error)
                
            }
        }

    }
    
    func requestRockets() {
        
        let url = self.baseURL+"rockets"
        GET.request(url) { (data) -> (Void) in
            do{
                let mystruct:[RocketsDTO] = try JSONDecoder().decode([RocketsDTO].self, from: data)
                print(mystruct)
                
            } catch{
                print(error)
                
            }
        }
        
    }
    
    func reuqestRoadster() {
        let url = self.baseURL+"roadster"
        GET.request(url) { (data) -> (Void) in
            do{
                let mystruct: RoadsterDTO = try JSONDecoder().decode(RoadsterDTO.self, from: data)
                print(mystruct)
                
            } catch{
                print(error)
                
            }
        }
    }
  
    
}
