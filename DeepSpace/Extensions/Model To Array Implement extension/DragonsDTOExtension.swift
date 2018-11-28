//
//  DragonsDTOExtension.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 27/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

extension DragonDTO : ConvertibleToArray {
    func toArray() -> [(property: String, value: String)] {
        let name = (property: "Name", value: "\(self.name!)")
        let type = (property: "Type", value: "\(self.type!)")
        let isActive = (property: "Is active", value: "\(self.active! ? "Yes" : "No")")
        let capacity = (property: "Crew capacity", value: "\(self.crew_capacity!)")
        let description = (property: "Description", value: "\(self.description!)")
        return [name, type, isActive, capacity, description]
    }
}
