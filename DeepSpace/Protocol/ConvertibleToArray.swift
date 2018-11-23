//
//  ConvertibleToArray.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 22/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
protocol ConvertibleToArray {
    func toArray() -> [(property: String, value: String)]
}
