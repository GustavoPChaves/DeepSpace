//
//  MinorPlanetExtension.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 25/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

extension MinorPlanet : ConvertibleToArray {
    func toArray() -> [(property: String, value: String)] {
        let name = (property: "Name", value: self.name ?? "No info available")
        return [name]
    }
}
