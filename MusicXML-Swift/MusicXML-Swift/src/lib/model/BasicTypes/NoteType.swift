//
//  NoteType.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/6/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import Foundation

enum NoteType: String {
    case none
    case _1024th = "1024th"
    case _512th = "512th"
    case _256th = "256th"
    case _128th = "128th"
    case _64th = "64th"
    case _32nd = "32nd"
    case _16th = "16th"
    case eighth
    case quarter
    case half
    case whole
    case breve
    case long
    case maxima
}
