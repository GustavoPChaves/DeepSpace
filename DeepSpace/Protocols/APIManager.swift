//
//  APIManager.swift
//  DeepSpace
//
//  Created by Adriel Freire on 12/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation
protocol APIManager {
    associatedtype element
    var baseURL: String{get}
    var key: String?{get}
    mutating func requestElement(withName elementName: element)
    
}
