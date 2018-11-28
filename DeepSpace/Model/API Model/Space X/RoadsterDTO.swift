//
//  RoadsterDTO.swift
//  DeepSpace
//
//  Created by Adriel Freire on 14/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
import UIKit

class RoadsterDTO: Codable {
    var name: String?
    var details: String?
    var flickr_images: [String]?
    var image: UIImage?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case details
        case flickr_images
    }
    
    init(name: String?, details: String?, images: [String]?) {
        self.name = name
        self.details = details
        self.flickr_images = images
        self.image = nil
    }
    
    required convenience init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)
    
        let name = try? decoder.decode(String.self, forKey: .name)
        let details = try? decoder.decode(String.self, forKey: .details)
        let flickr_images = try? decoder.decode([String].self, forKey: .flickr_images)
        
        self.init(name: name, details: details, images: flickr_images)
        GET.request(flickr_images?.first ?? "") { self.image = UIImage(data: $0) }
        
    }
    
}
