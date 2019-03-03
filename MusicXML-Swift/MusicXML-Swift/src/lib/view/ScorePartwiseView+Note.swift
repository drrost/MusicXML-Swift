//
//  ScorePartwiseView+Note.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/7/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import UIKit

extension ScorePartwiseView {

    static let kFillColor = UIColor.black
    static let kLineWidth: CGFloat = 1.5

    func draw(note: Note, context: CGContext, point: CGPoint) {

        context.saveGState()
        context.translateBy(x: point.x, y: point.y)

        drawDashIfNecessary(note: note, context: context)

        draw(note: note, context: context)

        context.restoreGState()
    }

    fileprivate func drawDashIfNecessary(note: Note, context: CGContext) {
        guard note.isRest == false else { return }
        if note.pitch.step == .C && note.pitch.octave == 4 {
            let dashXStartOffset: CGFloat = 3.0
            let dashLength: CGFloat = 19.0
            let dashYStartOfset: CGFloat = kStaffSpace

            let dashY: CGFloat = dashYStartOfset
            context.move(to: CGPoint(x: -dashXStartOffset, y: dashY))
            context.addLine(to: CGPoint(x: -dashXStartOffset + dashLength,
                                        y: dashY))

            context.drawPath(using: .fillStroke)
        }
    }

    fileprivate func draw(note: Note, context: CGContext) {

        context.saveGState()
        context.translateBy(x: 0.0, y: shiftForNote(note))

        if note.isRest {
            switch note.type {
            case .whole?:
                drawRestWhole(context: context)
            case .half?:
                drawRestHalf(context: context)
            case .quarter?:
                drawRestQuareter(context: context)
            case .eighth?:
                drawRestEighth(context: context)
            default:
                print("")
            }
        } else {
            switch note.type {
            case .whole?:
                drawWhole()
            case .quarter?:
                drawQuater(context: context, shoulStemDown: shoulStemDown(note.pitch))
            case .eighth?:
                drawEighth(context: context, shoulStemDown: shoulStemDown(note.pitch))
            default:
                print("")
            }
        }

        context.restoreGState()
    }

    fileprivate func shiftForNote(_ note: Note) -> CGFloat {

        guard note.isRest == false else { return 0.0 }

        let kStaffSpaceHalf = kStaffSpace / 2.0
        switch (note.pitch.step, note.pitch.octave) {
        case (.C?, 4):
            return kStaffSpaceHalf * 2.0 - 1 // 8.0
        case (.D?, 4):
            return kStaffSpaceHalf - 1.0  // 3.5
        case (.E?, 4):
            return -kStaffSpaceHalf + 3.5 // -1.0
        case (.F?, 4):
            return -kStaffSpaceHalf * 2.0 + 3.5 // -5.5
        case (.G?, 4):
            return -kStaffSpaceHalf * 3.0 + 3.5
        case (.A?, 4):
            return -kStaffSpaceHalf * 4.0 + 3.5
        case (.B?, 4):
            return -kStaffSpaceHalf * 5.0 + 3.5
        case (.C?, 5):
            return -kStaffSpaceHalf * 6.0 + 3.5
        default:
            return 0.0
        }
    }

    fileprivate func shoulStemDown(_ pitch: Pitch) -> Bool {
        switch (pitch.step, pitch.octave) {
        case (.B?, 4), (.C?, 5):
            return true
        default:
            return false
        }
    }

    fileprivate func drawWhole() {
        let noteHeadPath = UIBezierPath()
        noteHeadPath.move(to: CGPoint(x: 9.12, y: 0))
        noteHeadPath.addCurve(to: CGPoint(x: 0, y: 5.5),
                              controlPoint1: CGPoint(x: 4.03, y: 0.19),
                              controlPoint2: CGPoint(x: 0, y: 2.59))
        noteHeadPath.addCurve(to: CGPoint(x: 9.75, y: 11),
                              controlPoint1: CGPoint(x: 0, y: 8.54),
                              controlPoint2: CGPoint(x: 4.37, y: 11))
        noteHeadPath.addCurve(to: CGPoint(x: 19.5, y: 5.5),
                              controlPoint1: CGPoint(x: 15.13, y: 11),
                              controlPoint2: CGPoint(x: 19.5, y: 8.54))
        noteHeadPath.addCurve(to: CGPoint(x: 9.75, y: 0),
                              controlPoint1: CGPoint(x: 19.5, y: 2.47),
                              controlPoint2: CGPoint(x: 15.13, y: 0))
        noteHeadPath.addCurve(to: CGPoint(x: 9.12, y: 0),
                              controlPoint1: CGPoint(x: 9.54, y: 0),
                              controlPoint2: CGPoint(x: 9.33, y: -0))
        noteHeadPath.close()

        noteHeadPath.move(to: CGPoint(x: 7.5, y: 1.07))
        noteHeadPath.addCurve(to: CGPoint(x: 12, y: 2.85),
                              controlPoint1: CGPoint(x: 8.86, y: 0.93),
                              controlPoint2: CGPoint(x: 10.57, y: 1.56))
        noteHeadPath.addCurve(to: CGPoint(x: 13.62, y: 8.91),
                              controlPoint1: CGPoint(x: 14.15, y: 4.78),
                              controlPoint2: CGPoint(x: 14.87, y: 7.49))
        noteHeadPath.addLine(to: CGPoint(x: 13.59, y: 8.94))
        noteHeadPath.addCurve(to: CGPoint(x: 7.38, y: 7.97),
                              controlPoint1: CGPoint(x: 12.32, y: 10.35),
                              controlPoint2: CGPoint(x: 9.53, y: 9.92))
        noteHeadPath.addCurve(to: CGPoint(x: 5.78, y: 1.88),
                              controlPoint1: CGPoint(x: 5.22, y: 6.03),
                              controlPoint2: CGPoint(x: 4.51, y: 3.29))
        noteHeadPath.addCurve(to: CGPoint(x: 7.5, y: 1.07),
                              controlPoint1: CGPoint(x: 6.21, y: 1.4),
                              controlPoint2: CGPoint(x: 6.81, y: 1.14))
        noteHeadPath.close()
        noteHeadPath.fill()
    }

    fileprivate func drawQuater(context: CGContext, shoulStemDown: Bool = false) {

        context.saveGState()
        context.rotate(by: -24.35 * CGFloat.pi/180)

        let noteHeadPath = UIBezierPath(
            ovalIn: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 7.0))
        ScorePartwiseView.kFillColor.setFill()
        noteHeadPath.fill()
        context.restoreGState()

        let stemPath = UIBezierPath()

        if shoulStemDown == true {
            stemPath.move(to: CGPoint(x: 2.0, y: 2.0))
            stemPath.addLine(to: CGPoint(x: 2.0, y: 28.0))
        } else {
            stemPath.move(to: CGPoint(x: 10.0, y: 0.0))
            stemPath.addLine(to: CGPoint(x: 10.0, y: -28.0))
        }

        stemPath.lineWidth = ScorePartwiseView.kLineWidth
        stemPath.stroke()
    }

    fileprivate func drawEighth(context: CGContext, shoulStemDown: Bool = false) {
        // TODO: it's a copy/pasts of the previous method, fetch the code.
        context.saveGState()
        context.rotate(by: -24.35 * CGFloat.pi/180)

        let noteHeadPath = UIBezierPath(
            ovalIn: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 7.0))
        ScorePartwiseView.kFillColor.setFill()
        noteHeadPath.fill()
        context.restoreGState()

        let stemPath = UIBezierPath()

        if shoulStemDown == true {
            stemPath.move(to: CGPoint(x: 2.0, y: 2.0))
            stemPath.addLine(to: CGPoint(x: 2.0, y: 28.0))
        } else {
            stemPath.move(to: CGPoint(x: 10.0, y: 0.0))
            stemPath.addLine(to: CGPoint(x: 10.0, y: -28.0))
        }

        stemPath.lineWidth = ScorePartwiseView.kLineWidth
        stemPath.stroke()
    }

    // MARK: - Rests

    fileprivate static let kRestHeight = kStaffSpace * 0.6

    fileprivate func drawRestWhole(context: CGContext) {
        context.fill(CGRect(x: 0.0, y: -kStaffSpace * 3.0, width: 10.0, height: ScorePartwiseView.kRestHeight))
    }

    fileprivate func drawRestHalf(context: CGContext) {
        context.fill(CGRect(x: 0.0, y: -kStaffSpace * 3.0 + kStaffSpace * 0.4,
                            width: 10.0, height: ScorePartwiseView.kRestHeight))
    }

    fileprivate func drawRestQuareter(context: CGContext) {

        context.saveGState()
        context.translateBy(x: 0.0, y: -32.0)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 3.38, y: 0.36))
        path.addCurve(to: CGPoint(x: 3.1, y: 1.07),
                      controlPoint1: CGPoint(x: 3.13, y: 0.46),
                      controlPoint2: CGPoint(x: 2.98, y: 0.82))
        path.addCurve(to: CGPoint(x: 3.85, y: 2.01),
                      controlPoint1: CGPoint(x: 3.13, y: 1.11),
                      controlPoint2: CGPoint(x: 3.49, y: 1.54))
        path.addCurve(to: CGPoint(x: 4.99, y: 3.59),
                      controlPoint1: CGPoint(x: 4.67, y: 2.94),
                      controlPoint2: CGPoint(x: 4.81, y: 3.16))
        path.addCurve(to: CGPoint(x: 4.06, y: 8.11),
                      controlPoint1: CGPoint(x: 5.71, y: 5.05),
                      controlPoint2: CGPoint(x: 5.32, y: 6.92))
        path.addCurve(to: CGPoint(x: 3.05, y: 8.96),
                      controlPoint1: CGPoint(x: 3.95, y: 8.25),
                      controlPoint2: CGPoint(x: 3.49, y: 8.64))
        path.addCurve(to: CGPoint(x: 1.01, y: 11.19),
                      controlPoint1: CGPoint(x: 1.8, y: 10.04),
                      controlPoint2: CGPoint(x: 1.22, y: 10.65))
        path.addCurve(to: CGPoint(x: 0.94, y: 11.69),
                      controlPoint1: CGPoint(x: 0.94, y: 11.33),
                      controlPoint2: CGPoint(x: 0.94, y: 11.48))
        path.addCurve(to: CGPoint(x: 2.41, y: 13.95),
                      controlPoint1: CGPoint(x: 0.9, y: 12.19),
                      controlPoint2: CGPoint(x: 0.94, y: 12.23))
        path.addCurve(to: CGPoint(x: 5.96, y: 18.15),
                      controlPoint1: CGPoint(x: 4.42, y: 16.35),
                      controlPoint2: CGPoint(x: 5.85, y: 18.04))
        path.addLine(to: CGPoint(x: 6.07, y: 18.25))
        path.addLine(to: CGPoint(x: 5.93, y: 18.18))
        path.addCurve(to: CGPoint(x: 0.98, y: 17.33),
                      controlPoint1: CGPoint(x: 3.95, y: 17.36),
                      controlPoint2: CGPoint(x: 1.73, y: 16.97))
        path.addCurve(to: CGPoint(x: 0.47, y: 17.82),
                      controlPoint1: CGPoint(x: 0.72, y: 17.43),
                      controlPoint2: CGPoint(x: 0.58, y: 17.58))
        path.addCurve(to: CGPoint(x: 0.69, y: 20.66),
                      controlPoint1: CGPoint(x: 0.18, y: 18.44),
                      controlPoint2: CGPoint(x: 0.26, y: 19.34))
        path.addCurve(to: CGPoint(x: 2.66, y: 24.6),
                      controlPoint1: CGPoint(x: 1.08, y: 21.84),
                      controlPoint2: CGPoint(x: 1.87, y: 23.42))
        path.addCurve(to: CGPoint(x: 3.66, y: 25.93),
                      controlPoint1: CGPoint(x: 2.98, y: 25.11),
                      controlPoint2: CGPoint(x: 3.59, y: 25.89))
        path.addCurve(to: CGPoint(x: 4.02, y: 25.93),
                      controlPoint1: CGPoint(x: 3.77, y: 26.04),
                      controlPoint2: CGPoint(x: 3.92, y: 26))
        path.addCurve(to: CGPoint(x: 3.92, y: 25.43),
                      controlPoint1: CGPoint(x: 4.13, y: 25.79),
                      controlPoint2: CGPoint(x: 4.13, y: 25.68))
        path.addCurve(to: CGPoint(x: 3.24, y: 20.94),
                      controlPoint1: CGPoint(x: 3.17, y: 24.36),
                      controlPoint2: CGPoint(x: 2.81, y: 22.13))
        path.addCurve(to: CGPoint(x: 4.02, y: 19.94),
                      controlPoint1: CGPoint(x: 3.41, y: 20.41),
                      controlPoint2: CGPoint(x: 3.63, y: 20.12))
        path.addCurve(to: CGPoint(x: 8.33, y: 21.02),
                      controlPoint1: CGPoint(x: 5.06, y: 19.48),
                      controlPoint2: CGPoint(x: 7.36, y: 20.05))
        path.addCurve(to: CGPoint(x: 8.61, y: 21.27),
                      controlPoint1: CGPoint(x: 8.4, y: 21.09),
                      controlPoint2: CGPoint(x: 8.54, y: 21.23))
        path.addCurve(to: CGPoint(x: 9.33, y: 20.98),
                      controlPoint1: CGPoint(x: 8.87, y: 21.38),
                      controlPoint2: CGPoint(x: 9.23, y: 21.23))
        path.addCurve(to: CGPoint(x: 9.08, y: 20.16),
                      controlPoint1: CGPoint(x: 9.48, y: 20.73),
                      controlPoint2: CGPoint(x: 9.4, y: 20.55))
        path.addCurve(to: CGPoint(x: 6.39, y: 16.97),
                      controlPoint1: CGPoint(x: 8.47, y: 19.44),
                      controlPoint2: CGPoint(x: 6.64, y: 17.29))
        path.addCurve(to: CGPoint(x: 5.39, y: 14.6),
                      controlPoint1: CGPoint(x: 5.74, y: 16.21),
                      controlPoint2: CGPoint(x: 5.46, y: 15.5))
        path.addCurve(to: CGPoint(x: 6.68, y: 11.44),
                      controlPoint1: CGPoint(x: 5.35, y: 13.45),
                      controlPoint2: CGPoint(x: 5.81, y: 12.23))
        path.addCurve(to: CGPoint(x: 7.68, y: 10.58),
                      controlPoint1: CGPoint(x: 6.79, y: 11.3),
                      controlPoint2: CGPoint(x: 7.25, y: 10.9))
        path.addCurve(to: CGPoint(x: 9.76, y: 8.28),
                      controlPoint1: CGPoint(x: 9.01, y: 9.47),
                      controlPoint2: CGPoint(x: 9.55, y: 8.86))
        path.addCurve(to: CGPoint(x: 9.51, y: 6.99),
                      controlPoint1: CGPoint(x: 9.91, y: 7.82),
                      controlPoint2: CGPoint(x: 9.84, y: 7.39))
        path.addCurve(to: CGPoint(x: 6.68, y: 3.59),
                      controlPoint1: CGPoint(x: 9.4, y: 6.89),
                      controlPoint2: CGPoint(x: 8.15, y: 5.34))
        path.addCurve(to: CGPoint(x: 3.85, y: 0.32),
                      controlPoint1: CGPoint(x: 4.67, y: 1.22),
                      controlPoint2: CGPoint(x: 3.95, y: 0.36))
        path.addCurve(to: CGPoint(x: 3.38, y: 0.36),
                      controlPoint1: CGPoint(x: 3.7, y: 0.29),
                      controlPoint2: CGPoint(x: 3.52, y: 0.29))
        path.close()
        path.usesEvenOddFillRule = true
        UIColor.black.setFill()
        path.fill()
        UIColor.black.setStroke()
        path.lineWidth = 0.5
        path.lineJoinStyle = .round
        path.stroke()

        context.restoreGState()
    }

    fileprivate func drawRestEighth(context: CGContext) {

        context.saveGState()
        context.translateBy(x: 0.0, y: -26.0)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 2.53, y: 0.38))
        path.addCurve(to: CGPoint(x: 0.55, y: 2.1),
                      controlPoint1: CGPoint(x: 1.59, y: 0.56),
                      controlPoint2: CGPoint(x: 0.88, y: 1.21))
        path.addCurve(to: CGPoint(x: 0.48, y: 2.85),
                      controlPoint1: CGPoint(x: 0.48, y: 2.39),
                      controlPoint2: CGPoint(x: 0.48, y: 2.46))
        path.addCurve(to: CGPoint(x: 0.77, y: 4.11),
                      controlPoint1: CGPoint(x: 0.48, y: 3.39),
                      controlPoint2: CGPoint(x: 0.52, y: 3.68))
        path.addCurve(to: CGPoint(x: 2.74, y: 5.62),
                      controlPoint1: CGPoint(x: 1.13, y: 4.83),
                      controlPoint2: CGPoint(x: 1.88, y: 5.41))
        path.addCurve(to: CGPoint(x: 6.87, y: 5.08),
                      controlPoint1: CGPoint(x: 3.64, y: 5.87),
                      controlPoint2: CGPoint(x: 5.14, y: 5.65))
        path.addLine(to: CGPoint(x: 7.3, y: 4.93))
        path.addLine(to: CGPoint(x: 5.18, y: 10.78))
        path.addLine(to: CGPoint(x: 3.1, y: 16.63))
        path.addCurve(to: CGPoint(x: 3.28, y: 16.74),
                      controlPoint1: CGPoint(x: 3.1, y: 16.63),
                      controlPoint2: CGPoint(x: 3.17, y: 16.66))
        path.addCurve(to: CGPoint(x: 4.1, y: 16.99),
                      controlPoint1: CGPoint(x: 3.49, y: 16.88),
                      controlPoint2: CGPoint(x: 3.85, y: 16.99))
        path.addCurve(to: CGPoint(x: 5.14, y: 16.52),
                      controlPoint1: CGPoint(x: 4.53, y: 16.99),
                      controlPoint2: CGPoint(x: 5.07, y: 16.74))
        path.addCurve(to: CGPoint(x: 7.37, y: 8.99),
                      controlPoint1: CGPoint(x: 5.14, y: 16.45),
                      controlPoint2: CGPoint(x: 6.15, y: 13.04))
        path.addLine(to: CGPoint(x: 9.52, y: 1.57))
        path.addLine(to: CGPoint(x: 9.45, y: 1.46))
        path.addCurve(to: CGPoint(x: 8.69, y: 1.35),
                      controlPoint1: CGPoint(x: 9.27, y: 1.24),
                      controlPoint2: CGPoint(x: 8.91, y: 1.17))
        path.addCurve(to: CGPoint(x: 8.44, y: 1.67),
                      controlPoint1: CGPoint(x: 8.62, y: 1.42),
                      controlPoint2: CGPoint(x: 8.51, y: 1.57))
        path.addCurve(to: CGPoint(x: 6.87, y: 3.53),
                      controlPoint1: CGPoint(x: 8.12, y: 2.21),
                      controlPoint2: CGPoint(x: 7.3, y: 3.18))
        path.addCurve(to: CGPoint(x: 5.9, y: 3.75),
                      controlPoint1: CGPoint(x: 6.47, y: 3.86),
                      controlPoint2: CGPoint(x: 6.26, y: 3.89))
        path.addCurve(to: CGPoint(x: 5.25, y: 2.42),
                      controlPoint1: CGPoint(x: 5.57, y: 3.58),
                      controlPoint2: CGPoint(x: 5.47, y: 3.39))
        path.addCurve(to: CGPoint(x: 4.24, y: 0.67),
                      controlPoint1: CGPoint(x: 5.04, y: 1.46),
                      controlPoint2: CGPoint(x: 4.79, y: 1.02))
        path.addCurve(to: CGPoint(x: 2.53, y: 0.38),
                      controlPoint1: CGPoint(x: 3.74, y: 0.34),
                      controlPoint2: CGPoint(x: 3.1, y: 0.24))
        path.close()
        path.usesEvenOddFillRule = true
        UIColor.black.setFill()
        path.fill()
        UIColor.black.setStroke()
        path.lineWidth = 0.5
        path.lineJoinStyle = .round
        path.stroke()

        context.restoreGState()
    }

}
