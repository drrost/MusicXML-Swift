//
//  Time.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/6/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import Foundation

struct Time {

    static let xmlTag = "time"

    static let xmlBeatsTag = "beats"

    static let xmlBeatTypeTag = "beat-type"

    var beats: String!

    var beatType: String!
}
