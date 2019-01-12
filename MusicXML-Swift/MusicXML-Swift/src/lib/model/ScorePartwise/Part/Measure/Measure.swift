//
//  Measure.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/6/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import Foundation

class Measure {

    static let xmlTag = "measure"

    let number: Int

    // TODO: Make it clear.
    // The specification says that a `measure` tag must have 1:1 `attributes`
    // subelement, but there are a lot of .musicxml files on the Internet
    // where is an only `attributes` subelement (for the second `measure` element).
    // So, either the files are not accord the standard or something is wrong the
    // standard reading.
    var attributes: Attributes?

    var notes = [Note]()

    init(from dictionary: [String: String]) {
        if let numberString = dictionary["number"] {
            self.number = Int(numberString) ?? -1
        } else {
            number = -1
        }
    }
}
