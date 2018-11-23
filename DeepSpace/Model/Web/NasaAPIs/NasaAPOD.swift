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

    /// Gets the Astronomy Picture of the Day Object
    ///
    /// - Parameters:
    ///   - hd: If the image which will be returned will be HD
    ///   - date: The date of APOD
    ///   - completion: The handler of the API return
    public static func request(hd: Bool = true, date: Date = Date(timeIntervalSinceNow: 0), completion: @escaping (APOD) -> Void) {
        let hdString = hd ? "hd=true" : "hd=false"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = "date=\(dateFormatter.string(from: date))"
        
        GET.request(NasaAPOD.baseURL + hdString + "&\(NasaAPOD.key!)" + "&\(dateString)") { data in
            do {
                let apod = try JSONDecoder().decode(APOD.self, from: data)
                completion(apod)
            } catch {
                print("There was a JSON parse error. Error description: \(error.localizedDescription)")
            }
        }
    }
    
    /// Gets all Astronomy Picture of the Day Objects from the last 30 days, returning
    /// one by one in the completion
    ///
    /// - Parameters:
    ///   - hd: If the images which will be returned will be HD
    ///   - completion: The handler of the API return
    public static func getAPODsOfTheMonth(hd: Bool = true, completion: @escaping (APOD) -> Void) {
        DispatchQueue.global().async {
            let dayInSeconds = 60 * 60 * 24.0
            let semaphore = DispatchSemaphore(value: 0)
            
            for day in 0...30 {
                let date = Date(timeIntervalSinceNow: -dayInSeconds * Double(day))
                NasaAPOD.request(hd: hd, date: date) { apod in
                    completion(apod)
                    semaphore.signal()
                }
                semaphore.wait()
            }
        }
    }
    
}
