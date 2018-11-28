//
//  DragonDTO.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on November 14, 2018

import Foundation
import UIKit

class DragonDTO : Codable {
    
    var id: String?
    var name: String?
    var type: String?
    var flickr_images: [String]?
    var active: Bool?
    var crew_capacity: Int?
    var description: String?
    var image: UIImage?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case flickr_images
        case active
        case crew_capacity
        case description
    }
    
    init(id: String?, name: String?, type: String?, images: [String]?, active: Bool?, crew_capacity: Int?, description: String?) {
        self.id = id
        self.name = name
        self.type = type
        self.flickr_images = images
        self.active = active
        self.crew_capacity = crew_capacity
        self.description = description
        self.image = nil
    }
    
    required convenience init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try? decoder.decode(String.self, forKey: .id)
        let name = try? decoder.decode(String.self, forKey: .name)
        let type = try? decoder.decode(String.self, forKey: .type)
        let flickr_images = try? decoder.decode([String].self, forKey: .flickr_images)
        let active = try? decoder.decode(Bool.self, forKey: .active)
        let crew_capacity = try? decoder.decode(Int.self, forKey: .crew_capacity)
        let description = try? decoder.decode(String.self, forKey: .description)
        
        self.init(id: id, name: name, type: type, images: flickr_images, active: active, crew_capacity: crew_capacity, description: description)
        GET.request(flickr_images?.first ?? "") { self.image = UIImage(data: $0) }
        
    }
}

