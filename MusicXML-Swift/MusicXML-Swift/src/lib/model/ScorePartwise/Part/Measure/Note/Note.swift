//
//  Note.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/6/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import Foundation

enum Stem: String {
    case up
    case down
}

class Note {

    static let xmlTag = "note"

    static let xmPitchTag = "pitch"

    static let xmlRestTag = "rest"

    static let xmlDurationTag = "duration"

    static let xmlTypeTag = "type"

    static let xmlVoiceTag = "voice"

    static let xmlStemTag = "stem"

    var pitch: Pitch!

    var duration: UInt!

    var divisions: Int = 1

    fileprivate var _type = NoteType.none

    var type: NoteType! {
        get {
            if _type == .none {
                if (duration == 4 && divisions == 1) {
                    return .whole
                }
                if (duration == 4 && divisions == 2) {
                    return .half
                }
            }
            return _type
        }
        set {
            _type = newValue
        }
    }

    var voice: String?

    var isRest: Bool = false

    var stem: Stem?
}
