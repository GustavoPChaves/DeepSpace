//
//  RocketsDTOExtension.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 27/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

extension RocketsDTO : ConvertibleToArray {
    func toArray() -> [(property: String, value: String)] {
        let id = (property: "Number", value: "\(self.id!)")
        let isActive = (property: "Is active", value: "\(self.active! ? "Yes" : "No")")
        let stages = (property: "Stages", value: "\(self.stages!)")
        let height = (property: "Height", value: "\(self.height!.meters) meters")
        return [id, isActive, stages, height]
    }
}
