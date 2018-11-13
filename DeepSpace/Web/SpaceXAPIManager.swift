//
//  SpaceXAPIManager.swift
//  DeepSpace
//
//  Created by Adriel Freire on 12/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
class SpaceXAPIManager:APIManager {

    
    
    enum elements: String {
        case capsules
        case cores
        case dragons
        case history
        case landpads
        case launchs
        case launchpads
        case missions
        case payloads
        case rockets
        case roadster
        case ships
    }
    
    
    func requestElement(withName elementName: elements) {
        let url = self.baseURL+elementName.rawValue
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) 
                
                print(json)
                
                
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    
    var baseURL: String = "https://api.spacexdata.com/v3/"
    var key: String?
    
  
  
    
}
