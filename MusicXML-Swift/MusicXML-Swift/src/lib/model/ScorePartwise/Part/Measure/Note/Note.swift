//
//  Note.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/6/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import Foundation

struct Note {

    static let xmlTag = "note"

    static let xmPitchTag = "pitch"

    static let xmlDurationTag = "duration"

    static let xmlTypeTag = "type"

    var pitch: Pitch!

    var duration: UInt!

    var type: NoteType!
}
