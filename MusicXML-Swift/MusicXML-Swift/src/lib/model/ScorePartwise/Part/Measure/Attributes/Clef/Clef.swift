//
//  Clef.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/6/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import Foundation

struct Clef {

    static let xmlTag = "clef"

    static let xmlSignTag = "sign"

    static let xmlLineTag = "line"

    enum Sign: String {
        case G
        case F
        case C
        case percussion
        case TAB
        case jianpu
        case none
    }

    var sign: Sign!

    var line: Int?
}
