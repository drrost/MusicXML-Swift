//
//  ScorePartwiseView+Clef.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/7/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import UIKit

extension ScorePartwiseView {

    // MARK: - Public

    func draw(clef: Clef, _ context: CGContext,
              point: CGPoint = CGPoint(x: 0.0, y: 0.0)) {

        context.saveGState()
        context.translateBy(x: point.x, y: point.y)

        shift(to: clef.line, context)
        drawGClef(context)

        context.restoreGState()
    }

    // MARK: - Private

    fileprivate func shift(to line: Int?, _ context: CGContext) {
        let defaultLine = 2
        let line = line ?? defaultLine
        context.translateBy(x: 0.0, y: CGFloat(defaultLine - line) * kStaffSpace)
    }

    fileprivate func drawGClef(_ context: CGContext) {

        let scale: CGFloat = 1.3
        context.scaleBy(x: scale, y: scale)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 8.57, y: 22.43))
        path.addCurve(to: CGPoint(x: 6.74, y: 23.44),
                           controlPoint1: CGPoint(x: 7.92, y: 22.56),
                           controlPoint2: CGPoint(x: 7.32, y: 22.9))
        path.addCurve(to: CGPoint(x: 5.81, y: 25.34),
                           controlPoint1: CGPoint(x: 6.17, y: 24),
                           controlPoint2: CGPoint(x: 5.86, y: 24.63))
        path.addCurve(to: CGPoint(x: 6.16, y: 26.84),
                           controlPoint1: CGPoint(x: 5.78, y: 25.78),
                           controlPoint2: CGPoint(x: 5.9, y: 26.29))
        path.addCurve(to: CGPoint(x: 7.44, y: 28.11),
                           controlPoint1: CGPoint(x: 6.43, y: 27.4),
                           controlPoint2: CGPoint(x: 6.86, y: 27.82))
        path.addCurve(to: CGPoint(x: 7.71, y: 28.41),
                           controlPoint1: CGPoint(x: 7.63, y: 28.16),
                           controlPoint2: CGPoint(x: 7.72, y: 28.27))
        path.addCurve(to: CGPoint(x: 7.45, y: 28.53),
                           controlPoint1: CGPoint(x: 7.71, y: 28.46),
                           controlPoint2: CGPoint(x: 7.63, y: 28.51))
        path.addCurve(to: CGPoint(x: 5.21, y: 26.93),
                           controlPoint1: CGPoint(x: 6.51, y: 28.24),
                           controlPoint2: CGPoint(x: 5.77, y: 27.7))
        path.addCurve(to: CGPoint(x: 4.46, y: 24.32),
                           controlPoint1: CGPoint(x: 4.66, y: 26.15),
                           controlPoint2: CGPoint(x: 4.41, y: 25.28))
        path.addCurve(to: CGPoint(x: 5.63, y: 21.51),
                           controlPoint1: CGPoint(x: 4.56, y: 23.29),
                           controlPoint2: CGPoint(x: 4.95, y: 22.35))
        path.addCurve(to: CGPoint(x: 8.18, y: 19.77),
                           controlPoint1: CGPoint(x: 6.32, y: 20.66),
                           controlPoint2: CGPoint(x: 7.17, y: 20.08))
        path.addLine(to: CGPoint(x: 7.72, y: 16.17))
        path.addCurve(to: CGPoint(x: 3.5, y: 19.93),
                           controlPoint1: CGPoint(x: 6.02, y: 17.35),
                           controlPoint2: CGPoint(x: 4.62, y: 18.59))
        path.addCurve(to: CGPoint(x: 1.6, y: 24.36),
                           controlPoint1: CGPoint(x: 2.39, y: 21.25),
                           controlPoint2: CGPoint(x: 1.76, y: 22.73))
        path.addCurve(to: CGPoint(x: 1.92, y: 26.52),
                           controlPoint1: CGPoint(x: 1.57, y: 25.09),
                           controlPoint2: CGPoint(x: 1.67, y: 25.82))
        path.addCurve(to: CGPoint(x: 3.1, y: 28.49),
                           controlPoint1: CGPoint(x: 2.16, y: 27.23),
                           controlPoint2: CGPoint(x: 2.55, y: 27.88))
        path.addCurve(to: CGPoint(x: 7.55, y: 30.58),
                           controlPoint1: CGPoint(x: 4.2, y: 29.7),
                           controlPoint2: CGPoint(x: 5.69, y: 30.39))
        path.addCurve(to: CGPoint(x: 9.62, y: 30.38),
                           controlPoint1: CGPoint(x: 8.19, y: 30.58),
                           controlPoint2: CGPoint(x: 8.88, y: 30.51))
        path.addLine(to: CGPoint(x: 8.57, y: 22.43))
        path.close()
        path.move(to: CGPoint(x: 9.33, y: 22.38))
        path.addLine(to: CGPoint(x: 10.4, y: 30.19))
        path.addCurve(to: CGPoint(x: 13.11, y: 26.31),
                           controlPoint1: CGPoint(x: 12.06, y: 29.68),
                           controlPoint2: CGPoint(x: 12.96, y: 28.38))
        path.addCurve(to: CGPoint(x: 12.58, y: 24.41),
                           controlPoint1: CGPoint(x: 13.06, y: 25.62),
                           controlPoint2: CGPoint(x: 12.9, y: 24.98))
        path.addCurve(to: CGPoint(x: 11.29, y: 22.99),
                           controlPoint1: CGPoint(x: 12.28, y: 23.82),
                           controlPoint2: CGPoint(x: 11.85, y: 23.35))
        path.addCurve(to: CGPoint(x: 9.33, y: 22.38),
                           controlPoint1: CGPoint(x: 10.73, y: 22.63),
                           controlPoint2: CGPoint(x: 10.08, y: 22.43))
        path.close()

        path.move(to: CGPoint(x: 7.93, y: 11.81))
        path.addCurve(to: CGPoint(x: 9.18, y: 10.85),
                           controlPoint1: CGPoint(x: 8.29, y: 11.64),
                           controlPoint2: CGPoint(x: 8.72, y: 11.31))
        path.addCurve(to: CGPoint(x: 10.54, y: 9.24),
                           controlPoint1: CGPoint(x: 9.64, y: 10.4),
                           controlPoint2: CGPoint(x: 10.1, y: 9.85))
        path.addCurve(to: CGPoint(x: 11.66, y: 7.32),
                           controlPoint1: CGPoint(x: 11, y: 8.62),
                           controlPoint2: CGPoint(x: 11.37, y: 7.98))
        path.addCurve(to: CGPoint(x: 12.15, y: 5.47),
                           controlPoint1: CGPoint(x: 11.95, y: 6.67),
                           controlPoint2: CGPoint(x: 12.11, y: 6.05))
        path.addCurve(to: CGPoint(x: 12.13, y: 4.74),
                           controlPoint1: CGPoint(x: 12.16, y: 5.22),
                           controlPoint2: CGPoint(x: 12.16, y: 4.97))
        path.addCurve(to: CGPoint(x: 11.83, y: 3.89),
                           controlPoint1: CGPoint(x: 12.11, y: 4.38),
                           controlPoint2: CGPoint(x: 12.01, y: 4.09))
        path.addCurve(to: CGPoint(x: 11.09, y: 3.56),
                           controlPoint1: CGPoint(x: 11.64, y: 3.7),
                           controlPoint2: CGPoint(x: 11.4, y: 3.58))
        path.addCurve(to: CGPoint(x: 9.32, y: 4.56),
                           controlPoint1: CGPoint(x: 10.46, y: 3.52),
                           controlPoint2: CGPoint(x: 9.87, y: 3.85))
        path.addCurve(to: CGPoint(x: 8.21, y: 6.76),
                           controlPoint1: CGPoint(x: 8.88, y: 5.17),
                           controlPoint2: CGPoint(x: 8.51, y: 5.91))
        path.addCurve(to: CGPoint(x: 7.63, y: 9.34),
                           controlPoint1: CGPoint(x: 7.91, y: 7.62),
                           controlPoint2: CGPoint(x: 7.71, y: 8.47))
        path.addCurve(to: CGPoint(x: 7.93, y: 11.81),
                           controlPoint1: CGPoint(x: 7.61, y: 10.33),
                           controlPoint2: CGPoint(x: 7.72, y: 11.16))
        path.close()

        path.move(to: CGPoint(x: 7.24, y: 12.35))
        path.addCurve(to: CGPoint(x: 6.81, y: 7.34),
                           controlPoint1: CGPoint(x: 6.88, y: 10.7),
                           controlPoint2: CGPoint(x: 6.74, y: 9.03))
        path.addCurve(to: CGPoint(x: 7.37, y: 4.33),
                           controlPoint1: CGPoint(x: 6.9, y: 6.26),
                           controlPoint2: CGPoint(x: 7.08, y: 5.25))
        path.addCurve(to: CGPoint(x: 8.45, y: 1.93),
                           controlPoint1: CGPoint(x: 7.65, y: 3.4),
                           controlPoint2: CGPoint(x: 8.01, y: 2.61))
        path.addCurve(to: CGPoint(x: 9.91, y: 0.43),
                           controlPoint1: CGPoint(x: 8.89, y: 1.26),
                           controlPoint2: CGPoint(x: 9.38, y: 0.76))
        path.addCurve(to: CGPoint(x: 10.89, y: 0),
                           controlPoint1: CGPoint(x: 10.38, y: 0.14),
                           controlPoint2: CGPoint(x: 10.71, y: -0.01))
        path.addCurve(to: CGPoint(x: 11.24, y: 0.16),
                           controlPoint1: CGPoint(x: 11.03, y: 0.01),
                           controlPoint2: CGPoint(x: 11.14, y: 0.07))
        path.addCurve(to: CGPoint(x: 11.61, y: 0.63),
                           controlPoint1: CGPoint(x: 11.33, y: 0.26),
                           controlPoint2: CGPoint(x: 11.46, y: 0.42))
        path.addCurve(to: CGPoint(x: 13.04, y: 6.88),
                           controlPoint1: CGPoint(x: 12.73, y: 2.41),
                           controlPoint2: CGPoint(x: 13.21, y: 4.49))
        path.addCurve(to: CGPoint(x: 12.33, y: 10.18),
                           controlPoint1: CGPoint(x: 12.96, y: 8.01),
                           controlPoint2: CGPoint(x: 12.73, y: 9.1))
        path.addCurve(to: CGPoint(x: 10.76, y: 13.2),
                           controlPoint1: CGPoint(x: 11.95, y: 11.26),
                           controlPoint2: CGPoint(x: 11.43, y: 12.27))
        path.addCurve(to: CGPoint(x: 8.44, y: 15.62),
                           controlPoint1: CGPoint(x: 10.09, y: 14.14),
                           controlPoint2: CGPoint(x: 9.32, y: 14.95))
        path.addLine(to: CGPoint(x: 9, y: 19.63))
        path.addCurve(to: CGPoint(x: 9.96, y: 19.6),
                           controlPoint1: CGPoint(x: 9.46, y: 19.61),
                           controlPoint2: CGPoint(x: 9.78, y: 19.59))
        path.addCurve(to: CGPoint(x: 12.09, y: 20.22),
                           controlPoint1: CGPoint(x: 10.75, y: 19.65),
                           controlPoint2: CGPoint(x: 11.45, y: 19.86))
        path.addCurve(to: CGPoint(x: 13.67, y: 21.64),
                           controlPoint1: CGPoint(x: 12.72, y: 20.59),
                           controlPoint2: CGPoint(x: 13.25, y: 21.06))
        path.addCurve(to: CGPoint(x: 14.6, y: 23.57),
                           controlPoint1: CGPoint(x: 14.09, y: 22.21),
                           controlPoint2: CGPoint(x: 14.4, y: 22.86))
        path.addCurve(to: CGPoint(x: 14.82, y: 25.79),
                           controlPoint1: CGPoint(x: 14.79, y: 24.29),
                           controlPoint2: CGPoint(x: 14.88, y: 25.03))
        path.addCurve(to: CGPoint(x: 13.62, y: 28.96),
                           controlPoint1: CGPoint(x: 14.74, y: 26.97),
                           controlPoint2: CGPoint(x: 14.34, y: 28.04))
        path.addCurve(to: CGPoint(x: 10.54, y: 30.91),
                           controlPoint1: CGPoint(x: 12.9, y: 29.89),
                           controlPoint2: CGPoint(x: 11.88, y: 30.54))
        path.addCurve(to: CGPoint(x: 10.84, y: 33.06),
                           controlPoint1: CGPoint(x: 10.59, y: 31.41),
                           controlPoint2: CGPoint(x: 10.69, y: 32.13))
        path.addCurve(to: CGPoint(x: 11.15, y: 35.28),
                           controlPoint1: CGPoint(x: 10.98, y: 33.99),
                           controlPoint2: CGPoint(x: 11.09, y: 34.74))
        path.addCurve(to: CGPoint(x: 11.18, y: 36.87),
                           controlPoint1: CGPoint(x: 11.22, y: 35.83),
                           controlPoint2: CGPoint(x: 11.22, y: 36.36))
        path.addCurve(to: CGPoint(x: 10.44, y: 38.94),
                           controlPoint1: CGPoint(x: 11.13, y: 37.66),
                           controlPoint2: CGPoint(x: 10.88, y: 38.35))
        path.addCurve(to: CGPoint(x: 8.69, y: 40.28),
                           controlPoint1: CGPoint(x: 9.99, y: 39.54),
                           controlPoint2: CGPoint(x: 9.41, y: 39.98))
        path.addCurve(to: CGPoint(x: 6.41, y: 40.64),
                           controlPoint1: CGPoint(x: 7.99, y: 40.57),
                           controlPoint2: CGPoint(x: 7.23, y: 40.69))
        path.addCurve(to: CGPoint(x: 3.47, y: 39.52),
                           controlPoint1: CGPoint(x: 5.26, y: 40.56),
                           controlPoint2: CGPoint(x: 4.28, y: 40.18))
        path.addCurve(to: CGPoint(x: 2.29, y: 36.91),
                           controlPoint1: CGPoint(x: 2.66, y: 38.84),
                           controlPoint2: CGPoint(x: 2.26, y: 37.98))
        path.addCurve(to: CGPoint(x: 2.74, y: 35.6),
                           controlPoint1: CGPoint(x: 2.36, y: 36.44),
                           controlPoint2: CGPoint(x: 2.5, y: 36.01))
        path.addCurve(to: CGPoint(x: 3.67, y: 34.64),
                           controlPoint1: CGPoint(x: 2.98, y: 35.2),
                           controlPoint2: CGPoint(x: 3.29, y: 34.87))
        path.addCurve(to: CGPoint(x: 4.98, y: 34.28),
                           controlPoint1: CGPoint(x: 4.05, y: 34.39),
                           controlPoint2: CGPoint(x: 4.49, y: 34.28))
        path.addCurve(to: CGPoint(x: 6.12, y: 34.68),
                           controlPoint1: CGPoint(x: 5.39, y: 34.31),
                           controlPoint2: CGPoint(x: 5.77, y: 34.44))
        path.addCurve(to: CGPoint(x: 6.92, y: 35.62),
                           controlPoint1: CGPoint(x: 6.46, y: 34.92),
                           controlPoint2: CGPoint(x: 6.73, y: 35.23))
        path.addCurve(to: CGPoint(x: 7.16, y: 36.86),
                           controlPoint1: CGPoint(x: 7.1, y: 36),
                           controlPoint2: CGPoint(x: 7.19, y: 36.42))
        path.addCurve(to: CGPoint(x: 6.42, y: 38.32),
                           controlPoint1: CGPoint(x: 7.11, y: 37.45),
                           controlPoint2: CGPoint(x: 6.87, y: 37.94))
        path.addCurve(to: CGPoint(x: 4.79, y: 38.84),
                           controlPoint1: CGPoint(x: 5.97, y: 38.71),
                           controlPoint2: CGPoint(x: 5.43, y: 38.88))
        path.addLine(to: CGPoint(x: 4.55, y: 38.82))
        path.addCurve(to: CGPoint(x: 6.49, y: 39.87),
                           controlPoint1: CGPoint(x: 4.91, y: 39.45),
                           controlPoint2: CGPoint(x: 5.56, y: 39.81))
        path.addCurve(to: CGPoint(x: 7.94, y: 39.68),
                           controlPoint1: CGPoint(x: 6.96, y: 39.9),
                           controlPoint2: CGPoint(x: 7.45, y: 39.83))
        path.addCurve(to: CGPoint(x: 9.24, y: 39),
                           controlPoint1: CGPoint(x: 8.44, y: 39.52),
                           controlPoint2: CGPoint(x: 8.87, y: 39.3))
        path.addCurve(to: CGPoint(x: 9.98, y: 38.03),
                           controlPoint1: CGPoint(x: 9.6, y: 38.7),
                           controlPoint2: CGPoint(x: 9.86, y: 38.38))
        path.addCurve(to: CGPoint(x: 10.36, y: 36.35),
                           controlPoint1: CGPoint(x: 10.19, y: 37.63),
                           controlPoint2: CGPoint(x: 10.31, y: 37.06))
        path.addCurve(to: CGPoint(x: 10.32, y: 34.9),
                           controlPoint1: CGPoint(x: 10.4, y: 35.87),
                           controlPoint2: CGPoint(x: 10.38, y: 35.38))
        path.addCurve(to: CGPoint(x: 10.02, y: 32.98),
                           controlPoint1: CGPoint(x: 10.26, y: 34.42),
                           controlPoint2: CGPoint(x: 10.16, y: 33.78))
        path.addCurve(to: CGPoint(x: 9.72, y: 31.17),
                           controlPoint1: CGPoint(x: 9.87, y: 32.2),
                           controlPoint2: CGPoint(x: 9.77, y: 31.59))
        path.addCurve(to: CGPoint(x: 7.75, y: 31.27),
                           controlPoint1: CGPoint(x: 9.08, y: 31.28),
                           controlPoint2: CGPoint(x: 8.42, y: 31.32))
        path.addCurve(to: CGPoint(x: 4.57, y: 30.39),
                           controlPoint1: CGPoint(x: 6.61, y: 31.2),
                           controlPoint2: CGPoint(x: 5.55, y: 30.91))
        path.addCurve(to: CGPoint(x: 2.03, y: 28.34),
                           controlPoint1: CGPoint(x: 3.59, y: 29.87),
                           controlPoint2: CGPoint(x: 2.74, y: 29.19))
        path.addCurve(to: CGPoint(x: 0.44, y: 25.49),
                           controlPoint1: CGPoint(x: 1.32, y: 27.48),
                           controlPoint2: CGPoint(x: 0.79, y: 26.54))
        path.addCurve(to: CGPoint(x: 0.02, y: 22.27),
                           controlPoint1: CGPoint(x: 0.09, y: 24.45),
                           controlPoint2: CGPoint(x: -0.05, y: 23.38))
        path.addCurve(to: CGPoint(x: 0.84, y: 19.39),
                           controlPoint1: CGPoint(x: 0.13, y: 21.25),
                           controlPoint2: CGPoint(x: 0.4, y: 20.29))
        path.addCurve(to: CGPoint(x: 2.48, y: 16.85),
                           controlPoint1: CGPoint(x: 1.29, y: 18.48),
                           controlPoint2: CGPoint(x: 1.83, y: 17.63))
        path.addCurve(to: CGPoint(x: 4.49, y: 14.73),
                           controlPoint1: CGPoint(x: 3.14, y: 16.07),
                           controlPoint2: CGPoint(x: 3.81, y: 15.36))
        path.addCurve(to: CGPoint(x: 7.24, y: 12.35),
                           controlPoint1: CGPoint(x: 5.19, y: 14.11),
                           controlPoint2: CGPoint(x: 6.1, y: 13.31))
        path.close()
        path.usesEvenOddFillRule = true
        path.fill()
        path.lineWidth = 0.6
        path.miterLimit = 4
        path.stroke()
    }
}
