//
//  Pitch.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/6/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import Foundation

struct Pitch {

    static let xmlTag = "pitch"

    static let xmlStepTag = "step"

    static let xmlOctaveTag = "octave"

    var step: Step!

    var octave: UInt!
}
