//
//  APIManager.swift
//  astro_apis
//
//  Created by João Pedro Aragão on 13/11/18.
//  Copyright © 2018 João Pedro Aragão. All rights reserved.
//

import Foundation

protocol APIManager {
//    associatedtype Element
    static var baseURL: String {get}
    static var key: String? {get}
//    mutating func requestElement(withName elementName: Element)
    
}
