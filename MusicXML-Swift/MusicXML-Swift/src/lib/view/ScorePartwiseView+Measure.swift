//
//  ScorePartwiseView+Measure.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/12/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import UIKit

private let kDistanceBetweenNotes: CGFloat = 40.0

extension ScorePartwiseView {

    func draw(measure: Measure, context: CGContext) {
        var noteXStart: CGFloat = 70.0
        let notesYStart = kStaffTopOffset + CGFloat(kLinesNumber - 1) * kStaffSpace
        for note in measure.notes {
            draw(note: note, context: context,
                 point: CGPoint(x: noteXStart, y: notesYStart + 2.0))
            noteXStart += kDistanceBetweenNotes
        }
    }
}
