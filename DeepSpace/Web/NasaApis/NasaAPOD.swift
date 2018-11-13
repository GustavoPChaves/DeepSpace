//
//  NSAApod.swift
//  astro_apis
//
//  Created by João Pedro Aragão on 13/11/18.
//  Copyright © 2018 João Pedro Aragão. All rights reserved.
//

import Foundation

/// APOD = Astronomy Picture of the Day
struct NasaAPOD : APIManager {
    
    static var baseURL: String = "https://api.nasa.gov/planetary/apod?"
    static var key: String? = "api_key=LRtMpKrcsuGyVAPgzppIY55cdPoETsObmejYUsWv"

    /// Gets the Astronomy Picture of the Day JSON
    ///
    /// - Parameters:
    ///   - hd: If the image which will be returned will be HD
    ///   - completion: The handler of the API return
    public static func getJSON(hd: Bool = true, completion: @escaping ([String:Any]) -> Void) {
        let hdString = hd ? "hd=true" : "hd=false"
        GET.request(NasaAPOD.baseURL + "?" + hdString + "&" + NasaAPOD.key!) { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            completion(json!)
        }
    }
    
}
