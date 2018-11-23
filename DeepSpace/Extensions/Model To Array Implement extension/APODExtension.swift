//
//  APODExtension.swift
//  DeepSpace
//
//  Created by João Pedro Aragão on 22/11/18.
//  Copyright © 2018 Adriel Freire. All rights reserved.
//

import Foundation

extension APOD : ConvertibleToArray {
    func toArray() -> [(property: String, value: String)] {
        let title = (property: "Title", value: "\(self.title!)")
        let explanation = (property: "Explanation", value: "\(self.explanation!)")
        return [title, explanation]
    }
}
