//
//  Attributes.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/6/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import Foundation

struct Attributes {

    static let xmlTag = "attributes"

    static let xmlDivisionsTag = "divisions"

    static let xmlFifthsTag = "fifths"

    var divisions: Int?

    var key: Key!

    var time: Time!
}
