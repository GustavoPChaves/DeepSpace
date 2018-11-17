//
//  GET.swift
//  astro_apis
//
//  Created by João Pedro Aragão on 13/11/18.
//  Copyright © 2018 João Pedro Aragão. All rights reserved.
//

import Foundation

class GET {
    
    /// Get request method
    ///
    /// - Parameters:
    ///   - url: The full string with the url to call in the request
    ///   - completion: The handler of the request return
    public static func request(_ url: String, authentication: String? = nil, _ completion: @escaping (Data) -> (Void)) {
        guard let url = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if authentication != nil { request.setValue("Basic \(authentication!)", forHTTPHeaderField: "Authorization") }
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error != nil { print("There was an error. Error description: \(error!.localizedDescription)\n\(error!)") }
            
            if data == nil {
                print("No results returned")
                return
            }
            
            completion(data!)
            
            }.resume()
        
    }
    
}
