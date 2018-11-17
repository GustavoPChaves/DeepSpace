//
//  NASA_Techport.swift
//  astro_apis
//
//  Created by João Pedro Aragão on 13/11/18.
//  Copyright © 2018 João Pedro Aragão. All rights reserved.
//

import Foundation

struct NasaTechport : APIManager {
    
    static var baseURL: String = "https://api.nasa.gov/techport/api/projects/"
    static var key: String? = "api_key=LRtMpKrcsuGyVAPgzppIY55cdPoETsObmejYUsWv"
    
    /// Gets all projects IDs with valid identifier
    ///
    /// - Parameter completion: The handler of the API return
    public static func allProjectsIDs(completion: @escaping ([String:Any]) -> Void) {
        GET.request(NasaTechport.baseURL + "?" + NasaTechport.key!) { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            completion(json!)
        }
    }
    
    /// Gets a project by its ID
    ///
    /// - Parameters:
    ///   - id: The project ID
    ///   - completion: The handler of the API return
    public static func getProject(id: String, completion: @escaping ([String:Any]) -> Void) {
        GET.request(NasaTechport.baseURL + id + "?" + NasaTechport.key!) { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            completion(json!)
        }
    }
    
}
