//
//  RoadsterDTOExtension.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 27/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

extension RoadsterDTO : ConvertibleToArray {
    func toArray() -> [(property: String, value: String)] {
        let name = (property: "Name", value: "\(self.name!)")
        let details = (property: "Details", value: "\(self.details!)")
        return [name, details]
    }
}
