//
//  RocketsDTO.swift
//  DeepSpace
//
//  Created by Adriel Freire on 13/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
import UIKit

class RocketsDTO: Codable {
    var id: Int?
    var active: Bool?
    var stages: Int?
    var height: Height?
    var flickr_images: [String]?
    var image: UIImage?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case active
        case stages
        case height
        case flickr_images
    }
    
    init(id: Int?, active: Bool?, stages: Int?, height: Height?, images: [String]?) {
        self.id = id
        self.active = active
        self.stages = stages
        self.height = height
        self.flickr_images = images
        self.image = nil
    }
    
    required convenience init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try? decoder.decode(Int.self, forKey: .id)
        let active = try? decoder.decode(Bool.self, forKey: .active)
        let stages = try? decoder.decode(Int.self, forKey: .stages)
        let height = try? decoder.decode(Height.self, forKey: .height)
        let flickr_images = try? decoder.decode([String].self, forKey: .flickr_images)
        
        self.init(id: id, active: active, stages: stages, height: height, images: flickr_images)
        GET.request(flickr_images?.first ?? "") { self.image = UIImage(data: $0) }
        
    }
    
}

struct Height: Codable{
    var meters: Double
    var feet: Double
}
