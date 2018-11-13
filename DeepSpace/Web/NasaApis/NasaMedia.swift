//
//  NASA_Media.swift
//  astro_apis
//
//  Created by João Pedro Aragão on 13/11/18.
//  Copyright © 2018 João Pedro Aragão. All rights reserved.
//

import Foundation

struct NasaMedia : APIManager {
    
    static var baseURL: String = "https://images-api.nasa.gov/"
    static var key: String?
    
    
    /// The possible options to retrieve a media file
    ///
    /// - asset: Image or video
    /// - metadata: Data (json)
    /// - caption: Video captions
    public enum MediaOptions : String {
        case asset = "asset/"
        case metadata = "metadata/"
        case caption = "caption/"
    }
    
    
    /// The possible types of media file
    public enum MediaTypes : String {
        case image
        case audio
    }
    
    
    /// Searches for an image and/or video in the NASA database
    ///
    /// - Parameters:
    ///   - search: The search query
    ///   - keywords: Keywords option
    ///   - mediaTypes: The media types to search
    ///   - completion: The handler of the API return
    public static func search(search: String, keywords: [String] = [], mediaTypes: [MediaTypes] = [.image, .audio], completion: @escaping ([String:Any]) -> Void) {
        
        var keywordsEndpoint = ""
        if !keywords.isEmpty {
            keywordsEndpoint += "&keywords="
            for word in keywords {
                keywordsEndpoint += word
            }
        }
        
        var mediaTypesEndpoint = ""
        if !mediaTypes.isEmpty {
            mediaTypesEndpoint += "&media_type="
            for mediaType in mediaTypes {
                mediaTypesEndpoint += mediaType.rawValue
            }
        }
        
        let endpoint = search + keywordsEndpoint + mediaTypesEndpoint
        
        GET.request(NasaMedia.baseURL + "search?q=" + endpoint) { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            completion(json!)
        }
    }
    
    
    /// Gets a media file from nasa database
    ///
    /// - Parameters:
    ///   - option: The type of the media file
    ///   - id: The id of the looked for object
    ///   - completion: The handler of the API return
    public static func getResource(option: MediaOptions, id: String = "Earth Views", completion: @escaping ([String:Any]) -> Void) {
        GET.request(NasaMedia.baseURL + option.rawValue + id) { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            completion(json!)
        }
    }
    
}
