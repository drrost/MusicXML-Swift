//
//  Part.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/5/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import Foundation

struct Part {

    static let xmlTag = "part"

    var id: String!

    init(from dictionary: [String: String]) {
        if let id = dictionary["id"] {
            self.id = id
        }
    }
}
