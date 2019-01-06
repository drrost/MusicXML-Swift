//
//  Measure.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/6/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import Foundation

struct Measure {

    static let xmlTag = "measure"

    let number: Int

    var attributes: Attributes!

    var note: Note!

    init(from dictionary: [String: String]) {
        if let numberString = dictionary["number"] {
            self.number = Int(numberString) ?? -1
        } else {
            number = -1
        }
    }
}
