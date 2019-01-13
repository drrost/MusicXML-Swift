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

    func draw(measure: Measure, context: CGContext, startPoint: CGPoint) {
//        debugDrawCircle(startPoint, context)
        debugDrawPoint(startPoint, context)
        var lastPoint = CGPoint()
        var noteXStart: CGFloat = 0.0
        for note in measure.notes {
            lastPoint = CGPoint(x: startPoint.x + noteXStart, y: startPoint.y)
            draw(note: note, context: context, point: lastPoint)
            noteXStart += kDistanceBetweenNotes
        }
        drawClose(context, lastPoint)
    }

    fileprivate func drawClose(_ context: CGContext, _ lastPoint: CGPoint) {
        var point = CGPoint(x: lastPoint.x + kDistanceBetweenNotes,
                            y: lastPoint.y)
        context.move(to: point)
        point.y = lastPoint.y - kStaffSpace * CGFloat(kLinesNumber - 1)
        context.addLine(to: point)
    }
}
