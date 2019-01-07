//
//  ScorePartwiseView+Note.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/7/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import UIKit

extension ScorePartwiseView {

    func draw(note: Note, context: CGContext, point: CGPoint, scale: CGFloat = 1) {

        context.saveGState()
        context.translateBy(x: point.x, y: point.y)
        context.scaleBy(x: scale, y: scale)

        if note.pitch.step == .C && note.pitch.octave == 4 {
            let dashXStartOffset: CGFloat = 3.0
            let dashLength: CGFloat = 26.0
            let dashYStartOfset: CGFloat = 5.5

            let dashY: CGFloat = dashYStartOfset
            context.move(to: CGPoint(x: -dashXStartOffset, y: dashY))
            context.addLine(to: CGPoint(x: -dashXStartOffset + dashLength,
                                        y: dashY))

            context.drawPath(using: .fillStroke)
        }

        let path3937Path = UIBezierPath()
        path3937Path.move(to: CGPoint(x: 9.12, y: 0))
        path3937Path.addCurve(to: CGPoint(x: 0, y: 5.5),
                              controlPoint1: CGPoint(x: 4.03, y: 0.19),
                              controlPoint2: CGPoint(x: 0, y: 2.59))
        path3937Path.addCurve(to: CGPoint(x: 9.75, y: 11),
                              controlPoint1: CGPoint(x: 0, y: 8.54),
                              controlPoint2: CGPoint(x: 4.37, y: 11))
        path3937Path.addCurve(to: CGPoint(x: 19.5, y: 5.5), controlPoint1: CGPoint(x: 15.13, y: 11), controlPoint2: CGPoint(x: 19.5, y: 8.54))
        path3937Path.addCurve(to: CGPoint(x: 9.75, y: 0), controlPoint1: CGPoint(x: 19.5, y: 2.47), controlPoint2: CGPoint(x: 15.13, y: 0))
        path3937Path.addCurve(to: CGPoint(x: 9.12, y: 0), controlPoint1: CGPoint(x: 9.54, y: 0), controlPoint2: CGPoint(x: 9.33, y: -0))
        path3937Path.close()
        path3937Path.move(to: CGPoint(x: 7.5, y: 1.07))
        path3937Path.addCurve(to: CGPoint(x: 12, y: 2.85), controlPoint1: CGPoint(x: 8.86, y: 0.93), controlPoint2: CGPoint(x: 10.57, y: 1.56))
        path3937Path.addCurve(to: CGPoint(x: 13.62, y: 8.91), controlPoint1: CGPoint(x: 14.15, y: 4.78), controlPoint2: CGPoint(x: 14.87, y: 7.49))
        path3937Path.addLine(to: CGPoint(x: 13.59, y: 8.94))
        path3937Path.addCurve(to: CGPoint(x: 7.38, y: 7.97), controlPoint1: CGPoint(x: 12.32, y: 10.35), controlPoint2: CGPoint(x: 9.53, y: 9.92))
        path3937Path.addCurve(to: CGPoint(x: 5.78, y: 1.88), controlPoint1: CGPoint(x: 5.22, y: 6.03), controlPoint2: CGPoint(x: 4.51, y: 3.29))
        path3937Path.addCurve(to: CGPoint(x: 7.5, y: 1.07), controlPoint1: CGPoint(x: 6.21, y: 1.4), controlPoint2: CGPoint(x: 6.81, y: 1.14))
        path3937Path.close()
        path3937Path.fill()

        context.restoreGState()
    }
}
