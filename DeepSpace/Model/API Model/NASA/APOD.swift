//
//  APOD.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 14/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
import UIKit

class APOD : Codable {
    
    var title : String?
    var explanation : String?
    var date : String?
    var url : String?
    var hdurl : String?
    var mediaType : String?
    var serviceVersion : String?
    var copyright : String?
    var image : UIImage?
    
    private enum CodingKeys : String, CodingKey {
        case title
        case explanation
        case date
        case url
        case hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case copyright
    }
    
    public init(title: String?, explanation: String?, date: String?, url: String?, hdurl: String?, mediaType: String?, serviceVersion: String?, copyright: String?, image: UIImage?) {
        self.title = title
        self.explanation = explanation
        self.date = date
        self.url = url
        self.hdurl = hdurl
        self.mediaType = mediaType
        self.serviceVersion = serviceVersion
        self.copyright = copyright
        self.image = image
    }
    
    /// Manually decoder for autommatically set up the image, instead of only a link to it
    required convenience public init(from decoder: Decoder) throws {
        // Telling the decoder the keys to look for
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decoding process itself
        let title = try? container.decode(String.self, forKey: .title)
        let explanation = try? container.decode(String.self, forKey: .explanation)
        let date = try? container.decode(String.self, forKey: .date)
        let url = try? container.decode(String.self, forKey: .url)
        let hdurl = try? container.decode(String.self, forKey: .hdurl)
        let mediaType = try? container.decode(String.self, forKey: .mediaType)
        let serviceVersion =  try? container.decode(String.self, forKey: .serviceVersion)
        let copyright = try? container.decode(String.self, forKey: .copyright)
        
        self.init(title: title, explanation: explanation, date: date, url: url, hdurl: hdurl, mediaType: mediaType, serviceVersion: serviceVersion, copyright: copyright, image: nil)
        if mediaType != nil
        && mediaType == "image" {
            GET.request(url!) { self.image = UIImage(data: $0) }
        }
        
    }
    
}
