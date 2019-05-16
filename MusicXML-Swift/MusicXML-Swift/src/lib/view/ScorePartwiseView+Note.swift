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
            case ._16th?:
                drawRest16th(context: context)
            case ._32nd?:
                drawRest32nd(context: context)
            case ._64th?:
                drawRest64th(context: context)
            case ._128th?:
                drawRest128th(context: context)
            case ._256th?:
                drawRest256th(context: context)
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

    fileprivate func drawRest16th(context: CGContext) {

        context.saveGState()
        context.translateBy(x: 0.0, y: -26.0)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 5.34, y: 0.57))
        path.addCurve(to: CGPoint(x: 3.38, y: 2.28),
                      controlPoint1: CGPoint(x: 4.41, y: 0.74),
                      controlPoint2: CGPoint(x: 3.69, y: 1.39))
        path.addCurve(to: CGPoint(x: 3.3, y: 3.03),
                      controlPoint1: CGPoint(x: 3.3, y: 2.57),
                      controlPoint2: CGPoint(x: 3.3, y: 2.64))
        path.addCurve(to: CGPoint(x: 3.59, y: 4.29),
                      controlPoint1: CGPoint(x: 3.3, y: 3.57),
                      controlPoint2: CGPoint(x: 3.33, y: 3.86))
        path.addCurve(to: CGPoint(x: 5.56, y: 5.8),
                      controlPoint1: CGPoint(x: 3.95, y: 5.01),
                      controlPoint2: CGPoint(x: 4.7, y: 5.59))
        path.addCurve(to: CGPoint(x: 9.61, y: 5.3),
                      controlPoint1: CGPoint(x: 6.46, y: 6.05),
                      controlPoint2: CGPoint(x: 7.89, y: 5.87))
        path.addCurve(to: CGPoint(x: 10.08, y: 5.15),
                      controlPoint1: CGPoint(x: 9.87, y: 5.19),
                      controlPoint2: CGPoint(x: 10.08, y: 5.11))
        path.addCurve(to: CGPoint(x: 8.4, y: 10.61),
                      controlPoint1: CGPoint(x: 10.08, y: 5.19),
                      controlPoint2: CGPoint(x: 8.47, y: 10.42))
        path.addCurve(to: CGPoint(x: 7.07, y: 12.47),
                      controlPoint1: CGPoint(x: 8.21, y: 11.07),
                      controlPoint2: CGPoint(x: 7.6, y: 11.93))
        path.addCurve(to: CGPoint(x: 5.92, y: 12.9),
                      controlPoint1: CGPoint(x: 6.57, y: 12.97),
                      controlPoint2: CGPoint(x: 6.31, y: 13.08))
        path.addCurve(to: CGPoint(x: 5.27, y: 11.57),
                      controlPoint1: CGPoint(x: 5.6, y: 12.72),
                      controlPoint2: CGPoint(x: 5.49, y: 12.54))
        path.addCurve(to: CGPoint(x: 4.66, y: 10.18),
                      controlPoint1: CGPoint(x: 5.09, y: 10.85),
                      controlPoint2: CGPoint(x: 4.95, y: 10.46))
        path.addCurve(to: CGPoint(x: 1.62, y: 9.89),
                      controlPoint1: CGPoint(x: 3.91, y: 9.35),
                      controlPoint2: CGPoint(x: 2.62, y: 9.24))
        path.addCurve(to: CGPoint(x: 0.58, y: 11.25),
                      controlPoint1: CGPoint(x: 1.15, y: 10.21),
                      controlPoint2: CGPoint(x: 0.79, y: 10.71))
        path.addCurve(to: CGPoint(x: 0.5, y: 12),
                      controlPoint1: CGPoint(x: 0.5, y: 11.53),
                      controlPoint2: CGPoint(x: 0.5, y: 11.61))
        path.addCurve(to: CGPoint(x: 0.79, y: 13.26),
                      controlPoint1: CGPoint(x: 0.5, y: 12.54),
                      controlPoint2: CGPoint(x: 0.54, y: 12.83))
        path.addCurve(to: CGPoint(x: 2.76, y: 14.76),
                      controlPoint1: CGPoint(x: 1.15, y: 13.97),
                      controlPoint2: CGPoint(x: 1.9, y: 14.55))
        path.addCurve(to: CGPoint(x: 4.85, y: 14.76),
                      controlPoint1: CGPoint(x: 3.16, y: 14.87),
                      controlPoint2: CGPoint(x: 4.16, y: 14.87))
        path.addCurve(to: CGPoint(x: 6.78, y: 14.26),
                      controlPoint1: CGPoint(x: 5.41, y: 14.66),
                      controlPoint2: CGPoint(x: 6.1, y: 14.48))
        path.addCurve(to: CGPoint(x: 7.32, y: 14.12),
                      controlPoint1: CGPoint(x: 7.07, y: 14.16),
                      controlPoint2: CGPoint(x: 7.32, y: 14.09))
        path.addCurve(to: CGPoint(x: 3.73, y: 25.74),
                      controlPoint1: CGPoint(x: 7.32, y: 14.12),
                      controlPoint2: CGPoint(x: 3.8, y: 25.56))
        path.addCurve(to: CGPoint(x: 4.3, y: 26.06),
                      controlPoint1: CGPoint(x: 3.73, y: 25.77),
                      controlPoint2: CGPoint(x: 4.02, y: 25.99))
        path.addCurve(to: CGPoint(x: 5.17, y: 26.06),
                      controlPoint1: CGPoint(x: 4.59, y: 26.17),
                      controlPoint2: CGPoint(x: 4.88, y: 26.17))
        path.addCurve(to: CGPoint(x: 5.74, y: 25.7),
                      controlPoint1: CGPoint(x: 5.45, y: 25.99),
                      controlPoint2: CGPoint(x: 5.74, y: 25.81))
        path.addCurve(to: CGPoint(x: 8.97, y: 13.69),
                      controlPoint1: CGPoint(x: 5.77, y: 25.67),
                      controlPoint2: CGPoint(x: 7.21, y: 20.25))
        path.addLine(to: CGPoint(x: 12.16, y: 1.75))
        path.addLine(to: CGPoint(x: 12.09, y: 1.64))
        path.addCurve(to: CGPoint(x: 11.41, y: 1.49),
                      controlPoint1: CGPoint(x: 11.95, y: 1.42),
                      controlPoint2: CGPoint(x: 11.66, y: 1.39))
        path.addCurve(to: CGPoint(x: 10.84, y: 2.21),
                      controlPoint1: CGPoint(x: 11.26, y: 1.56),
                      controlPoint2: CGPoint(x: 11.26, y: 1.56))
        path.addCurve(to: CGPoint(x: 9.68, y: 3.68),
                      controlPoint1: CGPoint(x: 10.48, y: 2.79),
                      controlPoint2: CGPoint(x: 9.97, y: 3.39))
        path.addCurve(to: CGPoint(x: 8.72, y: 3.93),
                      controlPoint1: CGPoint(x: 9.29, y: 4),
                      controlPoint2: CGPoint(x: 9.08, y: 4.07))
        path.addCurve(to: CGPoint(x: 8.07, y: 2.6),
                      controlPoint1: CGPoint(x: 8.4, y: 3.76),
                      controlPoint2: CGPoint(x: 8.28, y: 3.57))
        path.addCurve(to: CGPoint(x: 7.07, y: 0.85),
                      controlPoint1: CGPoint(x: 7.85, y: 1.64),
                      controlPoint2: CGPoint(x: 7.6, y: 1.2))
        path.addCurve(to: CGPoint(x: 5.34, y: 0.57),
                      controlPoint1: CGPoint(x: 6.57, y: 0.52),
                      controlPoint2: CGPoint(x: 5.92, y: 0.42))
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

    fileprivate func drawRest32nd(context: CGContext) {

        context.saveGState()
        context.translateBy(x: 0.0, y: -35.0)

        let paths = UIBezierPath()
        paths.move(to: CGPoint(x: 7.5, y: 0.56))
        paths.addCurve(to: CGPoint(x: 5.53, y: 2.28),
                       controlPoint1: CGPoint(x: 6.57, y: 0.74),
                       controlPoint2: CGPoint(x: 5.84, y: 1.39))
        paths.addCurve(to: CGPoint(x: 5.45, y: 3.04),
                       controlPoint1: CGPoint(x: 5.45, y: 2.57),
                       controlPoint2: CGPoint(x: 5.45, y: 2.64))
        paths.addCurve(to: CGPoint(x: 5.53, y: 3.79),
                       controlPoint1: CGPoint(x: 5.45, y: 3.43),
                       controlPoint2: CGPoint(x: 5.45, y: 3.58))
        paths.addCurve(to: CGPoint(x: 7.07, y: 5.55),
                       controlPoint1: CGPoint(x: 5.77, y: 4.58),
                       controlPoint2: CGPoint(x: 6.28, y: 5.19))
        paths.addCurve(to: CGPoint(x: 8.61, y: 5.87),
                       controlPoint1: CGPoint(x: 7.6, y: 5.83),
                       controlPoint2: CGPoint(x: 7.85, y: 5.87))
        paths.addCurve(to: CGPoint(x: 11.59, y: 5.33),
                       controlPoint1: CGPoint(x: 9.54, y: 5.87),
                       controlPoint2: CGPoint(x: 10.33, y: 5.73))
        paths.addCurve(to: CGPoint(x: 12.16, y: 5.15),
                       controlPoint1: CGPoint(x: 11.91, y: 5.22),
                       controlPoint2: CGPoint(x: 12.16, y: 5.15))
        paths.addCurve(to: CGPoint(x: 11.44, y: 7.92),
                       controlPoint1: CGPoint(x: 12.19, y: 5.15),
                       controlPoint2: CGPoint(x: 11.87, y: 6.41))
        paths.addCurve(to: CGPoint(x: 10.62, y: 10.92),
                       controlPoint1: CGPoint(x: 10.91, y: 10.03),
                       controlPoint2: CGPoint(x: 10.69, y: 10.71))
        paths.addCurve(to: CGPoint(x: 9.33, y: 12.65),
                       controlPoint1: CGPoint(x: 10.33, y: 11.47),
                       controlPoint2: CGPoint(x: 9.72, y: 12.29))
        paths.addCurve(to: CGPoint(x: 8.4, y: 12.9),
                       controlPoint1: CGPoint(x: 8.97, y: 12.97),
                       controlPoint2: CGPoint(x: 8.75, y: 13.04))
        paths.addCurve(to: CGPoint(x: 7.75, y: 11.57),
                       controlPoint1: CGPoint(x: 8.07, y: 12.72),
                       controlPoint2: CGPoint(x: 7.96, y: 12.54))
        paths.addCurve(to: CGPoint(x: 7.14, y: 10.17),
                       controlPoint1: CGPoint(x: 7.57, y: 10.85),
                       controlPoint2: CGPoint(x: 7.43, y: 10.46))
        paths.addCurve(to: CGPoint(x: 4.09, y: 9.89),
                       controlPoint1: CGPoint(x: 6.39, y: 9.35),
                       controlPoint2: CGPoint(x: 5.09, y: 9.24))
        paths.addCurve(to: CGPoint(x: 3.05, y: 11.25),
                       controlPoint1: CGPoint(x: 3.62, y: 10.21),
                       controlPoint2: CGPoint(x: 3.26, y: 10.71))
        paths.addCurve(to: CGPoint(x: 2.98, y: 12),
                       controlPoint1: CGPoint(x: 2.98, y: 11.54),
                       controlPoint2: CGPoint(x: 2.98, y: 11.61))
        paths.addCurve(to: CGPoint(x: 3.26, y: 13.26),
                       controlPoint1: CGPoint(x: 2.98, y: 12.54),
                       controlPoint2: CGPoint(x: 3.02, y: 12.83))
        paths.addCurve(to: CGPoint(x: 5.24, y: 14.76),
                       controlPoint1: CGPoint(x: 3.62, y: 13.98),
                       controlPoint2: CGPoint(x: 4.38, y: 14.55))
        paths.addCurve(to: CGPoint(x: 7.32, y: 14.76),
                       controlPoint1: CGPoint(x: 5.63, y: 14.88),
                       controlPoint2: CGPoint(x: 6.64, y: 14.88))
        paths.addCurve(to: CGPoint(x: 9.26, y: 14.26),
                       controlPoint1: CGPoint(x: 7.89, y: 14.66),
                       controlPoint2: CGPoint(x: 8.57, y: 14.48))
        paths.addCurve(to: CGPoint(x: 9.83, y: 14.08),
                       controlPoint1: CGPoint(x: 9.58, y: 14.16),
                       controlPoint2: CGPoint(x: 9.83, y: 14.08))
        paths.addCurve(to: CGPoint(x: 8.32, y: 19.68),
                       controlPoint1: CGPoint(x: 9.83, y: 14.12),
                       controlPoint2: CGPoint(x: 8.4, y: 19.57))
        paths.addCurve(to: CGPoint(x: 7.03, y: 21.47),
                       controlPoint1: CGPoint(x: 8.04, y: 20.29),
                       controlPoint2: CGPoint(x: 7.46, y: 21.04))
        paths.addCurve(to: CGPoint(x: 5.92, y: 21.87),
                       controlPoint1: CGPoint(x: 6.57, y: 21.94),
                       controlPoint2: CGPoint(x: 6.32, y: 22.01))
        paths.addCurve(to: CGPoint(x: 5.28, y: 20.54),
                       controlPoint1: CGPoint(x: 5.6, y: 21.69),
                       controlPoint2: CGPoint(x: 5.49, y: 21.51))
        paths.addCurve(to: CGPoint(x: 4.66, y: 19.14),
                       controlPoint1: CGPoint(x: 5.09, y: 19.82),
                       controlPoint2: CGPoint(x: 4.95, y: 19.43))
        paths.addCurve(to: CGPoint(x: 1.62, y: 18.86),
                       controlPoint1: CGPoint(x: 3.91, y: 18.31),
                       controlPoint2: CGPoint(x: 2.62, y: 18.21))
        paths.addCurve(to: CGPoint(x: 0.58, y: 20.22),
                       controlPoint1: CGPoint(x: 1.15, y: 19.18),
                       controlPoint2: CGPoint(x: 0.79, y: 19.68))
        paths.addCurve(to: CGPoint(x: 0.5, y: 20.97),
                       controlPoint1: CGPoint(x: 0.5, y: 20.5),
                       controlPoint2: CGPoint(x: 0.5, y: 20.58))
        paths.addCurve(to: CGPoint(x: 0.58, y: 21.72),
                       controlPoint1: CGPoint(x: 0.5, y: 21.37),
                       controlPoint2: CGPoint(x: 0.5, y: 21.51))
        paths.addCurve(to: CGPoint(x: 2.12, y: 23.48),
                       controlPoint1: CGPoint(x: 0.82, y: 22.51),
                       controlPoint2: CGPoint(x: 1.33, y: 23.12))
        paths.addCurve(to: CGPoint(x: 3.69, y: 23.81),
                       controlPoint1: CGPoint(x: 2.69, y: 23.77),
                       controlPoint2: CGPoint(x: 2.9, y: 23.81))
        paths.addCurve(to: CGPoint(x: 4.92, y: 23.73),
                       controlPoint1: CGPoint(x: 4.27, y: 23.81),
                       controlPoint2: CGPoint(x: 4.45, y: 23.81))
        paths.addCurve(to: CGPoint(x: 7, y: 23.19),
                       controlPoint1: CGPoint(x: 5.56, y: 23.62),
                       controlPoint2: CGPoint(x: 6.25, y: 23.41))
        paths.addLine(to: CGPoint(x: 7.46, y: 23.01))
        paths.addLine(to: CGPoint(x: 7.46, y: 23.12))
        paths.addCurve(to: CGPoint(x: 4.38, y: 34.67),
                       controlPoint1: CGPoint(x: 7.43, y: 23.26),
                       controlPoint2: CGPoint(x: 4.41, y: 34.6))
        paths.addCurve(to: CGPoint(x: 5.38, y: 35.1),
                       controlPoint1: CGPoint(x: 4.34, y: 34.82),
                       controlPoint2: CGPoint(x: 4.99, y: 35.1))
        paths.addCurve(to: CGPoint(x: 6.39, y: 34.67),
                       controlPoint1: CGPoint(x: 5.77, y: 35.1),
                       controlPoint2: CGPoint(x: 6.35, y: 34.85))
        paths.addCurve(to: CGPoint(x: 10.3, y: 18.17),
                       controlPoint1: CGPoint(x: 6.42, y: 34.63),
                       controlPoint2: CGPoint(x: 8.14, y: 27.21))
        paths.addCurve(to: CGPoint(x: 14.06, y: 1.67),
                       controlPoint1: CGPoint(x: 14.13, y: 1.82),
                       controlPoint2: CGPoint(x: 14.13, y: 1.78))
        paths.addCurve(to: CGPoint(x: 13.56, y: 1.46),
                       controlPoint1: CGPoint(x: 13.95, y: 1.53),
                       controlPoint2: CGPoint(x: 13.78, y: 1.46))
        paths.addCurve(to: CGPoint(x: 12.95, y: 2.03),
                       controlPoint1: CGPoint(x: 13.31, y: 1.5),
                       controlPoint2: CGPoint(x: 13.2, y: 1.6))
        paths.addCurve(to: CGPoint(x: 11.55, y: 3.9),
                       controlPoint1: CGPoint(x: 12.45, y: 2.9),
                       controlPoint2: CGPoint(x: 11.87, y: 3.65))
        paths.addCurve(to: CGPoint(x: 10.87, y: 3.94),
                       controlPoint1: CGPoint(x: 11.34, y: 4.04),
                       controlPoint2: CGPoint(x: 11.15, y: 4.04))
        paths.addCurve(to: CGPoint(x: 10.23, y: 2.61),
                       controlPoint1: CGPoint(x: 10.55, y: 3.75),
                       controlPoint2: CGPoint(x: 10.44, y: 3.58))
        paths.addCurve(to: CGPoint(x: 9.22, y: 0.85),
                       controlPoint1: CGPoint(x: 10.01, y: 1.64),
                       controlPoint2: CGPoint(x: 9.75, y: 1.21))
        paths.addCurve(to: CGPoint(x: 7.5, y: 0.56),
                       controlPoint1: CGPoint(x: 8.72, y: 0.53),
                       controlPoint2: CGPoint(x: 8.07, y: 0.42))
        paths.close()
        paths.usesEvenOddFillRule = true
        UIColor.black.setFill()
        paths.fill()
        UIColor.black.setStroke()
        paths.lineWidth = 0.5
        paths.lineJoinStyle = .round
        paths.stroke()

        context.restoreGState()
    }

    fileprivate func drawRest64th(context: CGContext) {

        context.saveGState()
        context.translateBy(x: 0.0, y: -44.0)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 8.93, y: 0.56))
        path.addCurve(to: CGPoint(x: 6.96, y: 2.28),
                      controlPoint1: CGPoint(x: 8, y: 0.74),
                      controlPoint2: CGPoint(x: 7.28, y: 1.39))
        path.addCurve(to: CGPoint(x: 6.88, y: 3.04),
                      controlPoint1: CGPoint(x: 6.88, y: 2.57),
                      controlPoint2: CGPoint(x: 6.88, y: 2.64))
        path.addCurve(to: CGPoint(x: 6.96, y: 3.79),
                      controlPoint1: CGPoint(x: 6.88, y: 3.43),
                      controlPoint2: CGPoint(x: 6.88, y: 3.58))
        path.addCurve(to: CGPoint(x: 8.5, y: 5.55),
                      controlPoint1: CGPoint(x: 7.21, y: 4.58),
                      controlPoint2: CGPoint(x: 7.71, y: 5.19))
        path.addCurve(to: CGPoint(x: 10.08, y: 5.87),
                      controlPoint1: CGPoint(x: 9.07, y: 5.83),
                      controlPoint2: CGPoint(x: 9.29, y: 5.87))
        path.addCurve(to: CGPoint(x: 11.26, y: 5.8),
                      controlPoint1: CGPoint(x: 10.62, y: 5.87),
                      controlPoint2: CGPoint(x: 10.83, y: 5.87))
        path.addCurve(to: CGPoint(x: 13.23, y: 5.26),
                      controlPoint1: CGPoint(x: 11.83, y: 5.69),
                      controlPoint2: CGPoint(x: 12.62, y: 5.48))
        path.addLine(to: CGPoint(x: 13.63, y: 5.12))
        path.addLine(to: CGPoint(x: 13.59, y: 5.26))
        path.addCurve(to: CGPoint(x: 12.98, y: 8.02),
                      controlPoint1: CGPoint(x: 13.56, y: 5.33),
                      controlPoint2: CGPoint(x: 13.3, y: 6.59))
        path.addCurve(to: CGPoint(x: 12.19, y: 11),
                      controlPoint1: CGPoint(x: 12.41, y: 10.53),
                      controlPoint2: CGPoint(x: 12.37, y: 10.68))
        path.addCurve(to: CGPoint(x: 10.83, y: 12.87),
                      controlPoint1: CGPoint(x: 11.8, y: 11.82),
                      controlPoint2: CGPoint(x: 11.23, y: 12.61))
        path.addCurve(to: CGPoint(x: 10.19, y: 12.9),
                      controlPoint1: CGPoint(x: 10.62, y: 13.01),
                      controlPoint2: CGPoint(x: 10.43, y: 13.01))
        path.addCurve(to: CGPoint(x: 9.54, y: 11.57),
                      controlPoint1: CGPoint(x: 9.87, y: 12.72),
                      controlPoint2: CGPoint(x: 9.75, y: 12.54))
        path.addCurve(to: CGPoint(x: 8.93, y: 10.17),
                      controlPoint1: CGPoint(x: 9.36, y: 10.85),
                      controlPoint2: CGPoint(x: 9.22, y: 10.46))
        path.addCurve(to: CGPoint(x: 5.88, y: 9.89),
                      controlPoint1: CGPoint(x: 8.18, y: 9.35),
                      controlPoint2: CGPoint(x: 6.88, y: 9.24))
        path.addCurve(to: CGPoint(x: 4.85, y: 11.25),
                      controlPoint1: CGPoint(x: 5.41, y: 10.21),
                      controlPoint2: CGPoint(x: 5.06, y: 10.71))
        path.addCurve(to: CGPoint(x: 4.77, y: 12),
                      controlPoint1: CGPoint(x: 4.77, y: 11.54),
                      controlPoint2: CGPoint(x: 4.77, y: 11.61))
        path.addCurve(to: CGPoint(x: 5.06, y: 13.26),
                      controlPoint1: CGPoint(x: 4.77, y: 12.54),
                      controlPoint2: CGPoint(x: 4.8, y: 12.83))
        path.addCurve(to: CGPoint(x: 7.03, y: 14.76),
                      controlPoint1: CGPoint(x: 5.41, y: 13.98),
                      controlPoint2: CGPoint(x: 6.17, y: 14.55))
        path.addCurve(to: CGPoint(x: 9.11, y: 14.76),
                      controlPoint1: CGPoint(x: 7.42, y: 14.88),
                      controlPoint2: CGPoint(x: 8.43, y: 14.88))
        path.addCurve(to: CGPoint(x: 11.05, y: 14.26),
                      controlPoint1: CGPoint(x: 9.68, y: 14.66),
                      controlPoint2: CGPoint(x: 10.36, y: 14.48))
        path.addCurve(to: CGPoint(x: 11.62, y: 14.08),
                      controlPoint1: CGPoint(x: 11.37, y: 14.16),
                      controlPoint2: CGPoint(x: 11.59, y: 14.08))
        path.addCurve(to: CGPoint(x: 10.33, y: 19.68),
                      controlPoint1: CGPoint(x: 11.62, y: 14.12),
                      controlPoint2: CGPoint(x: 10.4, y: 19.5))
        path.addCurve(to: CGPoint(x: 9.11, y: 21.51),
                      controlPoint1: CGPoint(x: 10.11, y: 20.14),
                      controlPoint2: CGPoint(x: 9.54, y: 21.04))
        path.addCurve(to: CGPoint(x: 8.04, y: 21.87),
                      controlPoint1: CGPoint(x: 8.64, y: 21.94),
                      controlPoint2: CGPoint(x: 8.43, y: 22.01))
        path.addCurve(to: CGPoint(x: 7.39, y: 20.54),
                      controlPoint1: CGPoint(x: 7.71, y: 21.69),
                      controlPoint2: CGPoint(x: 7.6, y: 21.51))
        path.addCurve(to: CGPoint(x: 6.78, y: 19.14),
                      controlPoint1: CGPoint(x: 7.21, y: 19.82),
                      controlPoint2: CGPoint(x: 7.07, y: 19.43))
        path.addCurve(to: CGPoint(x: 3.73, y: 18.86),
                      controlPoint1: CGPoint(x: 6.03, y: 18.31),
                      controlPoint2: CGPoint(x: 4.73, y: 18.21))
        path.addCurve(to: CGPoint(x: 2.69, y: 20.22),
                      controlPoint1: CGPoint(x: 3.26, y: 19.18),
                      controlPoint2: CGPoint(x: 2.9, y: 19.68))
        path.addCurve(to: CGPoint(x: 2.62, y: 20.97),
                      controlPoint1: CGPoint(x: 2.62, y: 20.5),
                      controlPoint2: CGPoint(x: 2.62, y: 20.58))
        path.addCurve(to: CGPoint(x: 2.9, y: 22.22),
                      controlPoint1: CGPoint(x: 2.62, y: 21.51),
                      controlPoint2: CGPoint(x: 2.65, y: 21.8))
        path.addCurve(to: CGPoint(x: 4.88, y: 23.73),
                      controlPoint1: CGPoint(x: 3.26, y: 22.94),
                      controlPoint2: CGPoint(x: 4.02, y: 23.52))
        path.addCurve(to: CGPoint(x: 9.11, y: 23.19),
                      controlPoint1: CGPoint(x: 5.81, y: 23.98),
                      controlPoint2: CGPoint(x: 7.35, y: 23.77))
        path.addCurve(to: CGPoint(x: 9.61, y: 23.01),
                      controlPoint1: CGPoint(x: 9.36, y: 23.09),
                      controlPoint2: CGPoint(x: 9.61, y: 23.01))
        path.addCurve(to: CGPoint(x: 9, y: 25.7),
                      controlPoint1: CGPoint(x: 9.61, y: 23.05),
                      controlPoint2: CGPoint(x: 9.32, y: 24.23))
        path.addCurve(to: CGPoint(x: 8.25, y: 28.71),
                      controlPoint1: CGPoint(x: 8.46, y: 28.21),
                      controlPoint2: CGPoint(x: 8.43, y: 28.4))
        path.addCurve(to: CGPoint(x: 6.88, y: 30.58),
                      controlPoint1: CGPoint(x: 7.96, y: 29.33),
                      controlPoint2: CGPoint(x: 7.32, y: 30.19))
        path.addCurve(to: CGPoint(x: 5.92, y: 30.83),
                      controlPoint1: CGPoint(x: 6.52, y: 30.91),
                      controlPoint2: CGPoint(x: 6.28, y: 30.98))
        path.addCurve(to: CGPoint(x: 5.27, y: 29.51),
                      controlPoint1: CGPoint(x: 5.6, y: 30.65),
                      controlPoint2: CGPoint(x: 5.48, y: 30.47))
        path.addCurve(to: CGPoint(x: 4.66, y: 28.11),
                      controlPoint1: CGPoint(x: 5.09, y: 28.79),
                      controlPoint2: CGPoint(x: 4.95, y: 28.4))
        path.addCurve(to: CGPoint(x: 1.61, y: 27.82),
                      controlPoint1: CGPoint(x: 3.91, y: 27.28),
                      controlPoint2: CGPoint(x: 2.61, y: 27.17))
        path.addCurve(to: CGPoint(x: 0.58, y: 29.18),
                      controlPoint1: CGPoint(x: 1.15, y: 28.14),
                      controlPoint2: CGPoint(x: 0.79, y: 28.64))
        path.addCurve(to: CGPoint(x: 0.5, y: 29.94),
                      controlPoint1: CGPoint(x: 0.5, y: 29.47),
                      controlPoint2: CGPoint(x: 0.5, y: 29.54))
        path.addCurve(to: CGPoint(x: 0.79, y: 31.19),
                      controlPoint1: CGPoint(x: 0.5, y: 30.47),
                      controlPoint2: CGPoint(x: 0.53, y: 30.76))
        path.addCurve(to: CGPoint(x: 2.76, y: 32.7),
                      controlPoint1: CGPoint(x: 1.15, y: 31.91),
                      controlPoint2: CGPoint(x: 1.9, y: 32.48))
        path.addCurve(to: CGPoint(x: 7.24, y: 32.09),
                      controlPoint1: CGPoint(x: 3.69, y: 32.95),
                      controlPoint2: CGPoint(x: 5.48, y: 32.7))
        path.addCurve(to: CGPoint(x: 7.6, y: 31.98),
                      controlPoint1: CGPoint(x: 7.46, y: 32.02),
                      controlPoint2: CGPoint(x: 7.6, y: 31.98))
        path.addCurve(to: CGPoint(x: 4.99, y: 43.63),
                      controlPoint1: CGPoint(x: 7.6, y: 32.02),
                      controlPoint2: CGPoint(x: 5.09, y: 43.28))
        path.addCurve(to: CGPoint(x: 5.16, y: 43.82),
                      controlPoint1: CGPoint(x: 4.99, y: 43.71),
                      controlPoint2: CGPoint(x: 5.02, y: 43.75))
        path.addCurve(to: CGPoint(x: 5.99, y: 44.07),
                      controlPoint1: CGPoint(x: 5.38, y: 43.96),
                      controlPoint2: CGPoint(x: 5.74, y: 44.07))
        path.addCurve(to: CGPoint(x: 6.81, y: 43.82),
                      controlPoint1: CGPoint(x: 6.24, y: 44.07),
                      controlPoint2: CGPoint(x: 6.59, y: 43.96))
        path.addCurve(to: CGPoint(x: 7.03, y: 43.53),
                      controlPoint1: CGPoint(x: 6.96, y: 43.75),
                      controlPoint2: CGPoint(x: 7, y: 43.71))
        path.addCurve(to: CGPoint(x: 11.26, y: 22.55),
                      controlPoint1: CGPoint(x: 7.03, y: 43.42),
                      controlPoint2: CGPoint(x: 8.93, y: 33.99))
        path.addCurve(to: CGPoint(x: 15.38, y: 1.67),
                      controlPoint1: CGPoint(x: 14.96, y: 4.11),
                      controlPoint2: CGPoint(x: 15.42, y: 1.75))
        path.addCurve(to: CGPoint(x: 14.92, y: 1.43),
                      controlPoint1: CGPoint(x: 15.28, y: 1.5),
                      controlPoint2: CGPoint(x: 15.14, y: 1.43))
        path.addCurve(to: CGPoint(x: 14.2, y: 2.11),
                      controlPoint1: CGPoint(x: 14.6, y: 1.43),
                      controlPoint2: CGPoint(x: 14.53, y: 1.5))
        path.addCurve(to: CGPoint(x: 12.95, y: 3.9),
                      controlPoint1: CGPoint(x: 13.74, y: 3),
                      controlPoint2: CGPoint(x: 13.27, y: 3.65))
        path.addCurve(to: CGPoint(x: 12.3, y: 3.94),
                      controlPoint1: CGPoint(x: 12.77, y: 4.04),
                      controlPoint2: CGPoint(x: 12.59, y: 4.04))
        path.addCurve(to: CGPoint(x: 11.66, y: 2.61),
                      controlPoint1: CGPoint(x: 11.98, y: 3.75),
                      controlPoint2: CGPoint(x: 11.87, y: 3.58))
        path.addCurve(to: CGPoint(x: 10.65, y: 0.85),
                      controlPoint1: CGPoint(x: 11.44, y: 1.64),
                      controlPoint2: CGPoint(x: 11.19, y: 1.21))
        path.addCurve(to: CGPoint(x: 8.93, y: 0.56),
                      controlPoint1: CGPoint(x: 10.15, y: 0.53),
                      controlPoint2: CGPoint(x: 9.51, y: 0.42))
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

    fileprivate func drawRest128th(context: CGContext) {

        context.saveGState()
        context.translateBy(x: 0.0, y: -43.0)
        let kScale = CGFloat(1.15)
        context.scaleBy(x: kScale, y: kScale)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10.83, y: -0.01))
        path.addCurve(to: CGPoint(x: 12.78, y: 3.36),
                      controlPoint1: CGPoint(x: 13.15, y: 0.01),
                      controlPoint2: CGPoint(x: 13.03, y: 2.15))
        path.addCurve(to: CGPoint(x: 16.36, y: 0.84),
                      controlPoint1: CGPoint(x: 14.44, y: 3.06),
                      controlPoint2: CGPoint(x: 15.55, y: 1.92))
        path.addLine(to: CGPoint(x: 17, y: 0.83))
        path.addLine(to: CGPoint(x: 10.81, y: 22.85))
        path.addLine(to: CGPoint(x: 4.64, y: 45))
        path.addLine(to: CGPoint(x: 4.05, y: 45))
        path.addLine(to: CGPoint(x: 3.46, y: 45))
        path.addCurve(to: CGPoint(x: 6.48, y: 34.72),
                      controlPoint1: CGPoint(x: 4.47, y: 41.57),
                      controlPoint2: CGPoint(x: 5.48, y: 38.15))
        path.addCurve(to: CGPoint(x: 2.82, y: 35.6),
                      controlPoint1: CGPoint(x: 6.48, y: 34.72),
                      controlPoint2: CGPoint(x: 4.17, y: 35.6))
        path.addCurve(to: CGPoint(x: 0.02, y: 33.26),
                      controlPoint1: CGPoint(x: 1.34, y: 35.6),
                      controlPoint2: CGPoint(x: 0.09, y: 34.89))
        path.addCurve(to: CGPoint(x: 2.32, y: 31.07),
                      controlPoint1: CGPoint(x: 0.05, y: 32.24),
                      controlPoint2: CGPoint(x: 0.54, y: 31.07))
        path.addCurve(to: CGPoint(x: 4.42, y: 32.94),
                      controlPoint1: CGPoint(x: 3.82, y: 31.07),
                      controlPoint2: CGPoint(x: 4.43, y: 31.97))
        path.addCurve(to: CGPoint(x: 4.22, y: 34.35),
                      controlPoint1: CGPoint(x: 4.43, y: 33.48),
                      controlPoint2: CGPoint(x: 4.35, y: 33.99))
        path.addCurve(to: CGPoint(x: 6.86, y: 32.94),
                      controlPoint1: CGPoint(x: 5.7, y: 34.46),
                      controlPoint2: CGPoint(x: 6.7, y: 33.46))
        path.addLine(to: CGPoint(x: 8.51, y: 26.86))
        path.addCurve(to: CGPoint(x: 5.25, y: 27.83),
                      controlPoint1: CGPoint(x: 7.8, y: 27.26),
                      controlPoint2: CGPoint(x: 6.62, y: 27.83))
        path.addCurve(to: CGPoint(x: 2.32, y: 25.49),
                      controlPoint1: CGPoint(x: 3.85, y: 27.83),
                      controlPoint2: CGPoint(x: 2.33, y: 27.01))
        path.addCurve(to: CGPoint(x: 4.52, y: 23.3),
                      controlPoint1: CGPoint(x: 2.33, y: 24.27),
                      controlPoint2: CGPoint(x: 3.23, y: 23.3))
        path.addCurve(to: CGPoint(x: 6.65, y: 25.35),
                      controlPoint1: CGPoint(x: 5.89, y: 23.3),
                      controlPoint2: CGPoint(x: 6.63, y: 24.39))
        path.addCurve(to: CGPoint(x: 6.33, y: 26.5),
                      controlPoint1: CGPoint(x: 6.66, y: 26),
                      controlPoint2: CGPoint(x: 6.47, y: 26.28))
        path.addCurve(to: CGPoint(x: 8.98, y: 25.21),
                      controlPoint1: CGPoint(x: 8.02, y: 26.54),
                      controlPoint2: CGPoint(x: 8.9, y: 25.48))
        path.addLine(to: CGPoint(x: 10.74, y: 18.86))
        path.addCurve(to: CGPoint(x: 7.17, y: 19.74),
                      controlPoint1: CGPoint(x: 9.53, y: 19.44),
                      controlPoint2: CGPoint(x: 8.34, y: 19.74))
        path.addCurve(to: CGPoint(x: 4.45, y: 17.41),
                      controlPoint1: CGPoint(x: 5.4, y: 19.74),
                      controlPoint2: CGPoint(x: 4.52, y: 18.8))
        path.addCurve(to: CGPoint(x: 6.63, y: 15.21),
                      controlPoint1: CGPoint(x: 4.48, y: 16.34),
                      controlPoint2: CGPoint(x: 5.09, y: 15.21))
        path.addCurve(to: CGPoint(x: 8.76, y: 17.17),
                      controlPoint1: CGPoint(x: 8.27, y: 15.21),
                      controlPoint2: CGPoint(x: 8.76, y: 16.36))
        path.addCurve(to: CGPoint(x: 8.56, y: 18.43),
                      controlPoint1: CGPoint(x: 8.75, y: 17.61),
                      controlPoint2: CGPoint(x: 8.7, y: 18.04))
        path.addCurve(to: CGPoint(x: 11.09, y: 17.07),
                      controlPoint1: CGPoint(x: 9.71, y: 18.66),
                      controlPoint2: CGPoint(x: 10.96, y: 17.45))
        path.addLine(to: CGPoint(x: 12.82, y: 11.1))
        path.addCurve(to: CGPoint(x: 9.46, y: 11.97),
                      controlPoint1: CGPoint(x: 11.72, y: 11.55),
                      controlPoint2: CGPoint(x: 10.61, y: 11.97))
        path.addCurve(to: CGPoint(x: 6.62, y: 9.56),
                      controlPoint1: CGPoint(x: 7.77, y: 11.96),
                      controlPoint2: CGPoint(x: 6.63, y: 10.88))
        path.addCurve(to: CGPoint(x: 8.71, y: 7.44),
                      controlPoint1: CGPoint(x: 6.63, y: 8.41),
                      controlPoint2: CGPoint(x: 7.49, y: 7.44))
        path.addCurve(to: CGPoint(x: 10.92, y: 9.37),
                      controlPoint1: CGPoint(x: 10.45, y: 7.44),
                      controlPoint2: CGPoint(x: 10.92, y: 8.57))
        path.addCurve(to: CGPoint(x: 10.64, y: 10.65),
                      controlPoint1: CGPoint(x: 10.92, y: 10),
                      controlPoint2: CGPoint(x: 10.78, y: 10.38))
        path.addCurve(to: CGPoint(x: 13.28, y: 9.4),
                      controlPoint1: CGPoint(x: 11.78, y: 10.82),
                      controlPoint2: CGPoint(x: 13.17, y: 9.74))
        path.addLine(to: CGPoint(x: 14.8, y: 3.64))
        path.addCurve(to: CGPoint(x: 11.63, y: 4.53),
                      controlPoint1: CGPoint(x: 13.87, y: 4),
                      controlPoint2: CGPoint(x: 12.92, y: 4.53))
        path.addCurve(to: CGPoint(x: 8.76, y: 2.18),
                      controlPoint1: CGPoint(x: 10.72, y: 4.52),
                      controlPoint2: CGPoint(x: 8.92, y: 4.29))
        path.addCurve(to: CGPoint(x: 10.83, y: -0.01),
                      controlPoint1: CGPoint(x: 8.73, y: 0.93),
                      controlPoint2: CGPoint(x: 9.79, y: -0))
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

    fileprivate func drawRest256th(context: CGContext) {

        context.saveGState()
        context.translateBy(x: 0.0, y: -51.0)
        let kScale = CGFloat(1.34)
        context.scaleBy(x: kScale, y: kScale)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10.35, y: 5.92))
        path.addCurve(to: CGPoint(x: 12.03, y: 8.85),
                      controlPoint1: CGPoint(x: 12.35, y: 5.93),
                      controlPoint2: CGPoint(x: 12.25, y: 7.8))
        path.addCurve(to: CGPoint(x: 14.92, y: 6.95),
                      controlPoint1: CGPoint(x: 12.57, y: 8.9),
                      controlPoint2: CGPoint(x: 14.52, y: 7.71))
        path.addCurve(to: CGPoint(x: 15.78, y: 3.15),
                      controlPoint1: CGPoint(x: 15.42, y: 6.25),
                      controlPoint2: CGPoint(x: 15.62, y: 4.01))
        path.addCurve(to: CGPoint(x: 12.94, y: 3.92),
                      controlPoint1: CGPoint(x: 15.21, y: 3.46),
                      controlPoint2: CGPoint(x: 14.2, y: 3.95))
        path.addCurve(to: CGPoint(x: 10.59, y: 1.85),
                      controlPoint1: CGPoint(x: 11.77, y: 3.95),
                      controlPoint2: CGPoint(x: 10.58, y: 3.05))
        path.addCurve(to: CGPoint(x: 12.32, y: 0.02),
                      controlPoint1: CGPoint(x: 10.6, y: 0.75),
                      controlPoint2: CGPoint(x: 11.29, y: -0))
        path.addCurve(to: CGPoint(x: 14.14, y: 1.81),
                      controlPoint1: CGPoint(x: 13.27, y: 0),
                      controlPoint2: CGPoint(x: 14.15, y: 1.08))
        path.addCurve(to: CGPoint(x: 14.06, y: 2.9),
                      controlPoint1: CGPoint(x: 14.15, y: 2.31),
                      controlPoint2: CGPoint(x: 14.16, y: 2.46))
        path.addCurve(to: CGPoint(x: 17.22, y: 0.71),
                      controlPoint1: CGPoint(x: 15.35, y: 2.71),
                      controlPoint2: CGPoint(x: 16.8, y: 1.4))
        path.addLine(to: CGPoint(x: 17.78, y: 0.71))
        path.addLine(to: CGPoint(x: 10.33, y: 25.8))
        path.addLine(to: CGPoint(x: 5.01, y: 45.05))
        path.addLine(to: CGPoint(x: 4.5, y: 45.05))
        path.addLine(to: CGPoint(x: 3.99, y: 45.05))
        path.addCurve(to: CGPoint(x: 6.6, y: 36.11),
                      controlPoint1: CGPoint(x: 4.86, y: 42.07),
                      controlPoint2: CGPoint(x: 5.73, y: 39.09))
        path.addCurve(to: CGPoint(x: 3.44, y: 36.88),
                      controlPoint1: CGPoint(x: 6.6, y: 36.11),
                      controlPoint2: CGPoint(x: 4.6, y: 36.87))
        path.addCurve(to: CGPoint(x: 1.02, y: 34.84),
                      controlPoint1: CGPoint(x: 2.16, y: 36.88),
                      controlPoint2: CGPoint(x: 1.08, y: 36.26))
        path.addCurve(to: CGPoint(x: 3.01, y: 32.93),
                      controlPoint1: CGPoint(x: 1.04, y: 33.96),
                      controlPoint2: CGPoint(x: 1.47, y: 32.94))
        path.addCurve(to: CGPoint(x: 4.82, y: 34.56),
                      controlPoint1: CGPoint(x: 4.3, y: 32.94),
                      controlPoint2: CGPoint(x: 4.82, y: 33.72))
        path.addCurve(to: CGPoint(x: 4.64, y: 35.79),
                      controlPoint1: CGPoint(x: 4.82, y: 35.04),
                      controlPoint2: CGPoint(x: 4.76, y: 35.47))
        path.addCurve(to: CGPoint(x: 6.92, y: 34.56),
                      controlPoint1: CGPoint(x: 5.92, y: 35.88),
                      controlPoint2: CGPoint(x: 6.78, y: 35.01))
        path.addLine(to: CGPoint(x: 8.35, y: 29.28))
        path.addCurve(to: CGPoint(x: 5.53, y: 30.12),
                      controlPoint1: CGPoint(x: 7.74, y: 29.63),
                      controlPoint2: CGPoint(x: 6.72, y: 30.12))
        path.addCurve(to: CGPoint(x: 3.01, y: 28.09),
                      controlPoint1: CGPoint(x: 4.33, y: 30.12),
                      controlPoint2: CGPoint(x: 3.01, y: 29.41))
        path.addCurve(to: CGPoint(x: 4.91, y: 26.18),
                      controlPoint1: CGPoint(x: 3.01, y: 27.03),
                      controlPoint2: CGPoint(x: 3.79, y: 26.19))
        path.addCurve(to: CGPoint(x: 6.74, y: 27.97),
                      controlPoint1: CGPoint(x: 6.09, y: 26.19),
                      controlPoint2: CGPoint(x: 6.72, y: 27.13))
        path.addCurve(to: CGPoint(x: 6.47, y: 28.97),
                      controlPoint1: CGPoint(x: 6.75, y: 28.53),
                      controlPoint2: CGPoint(x: 6.59, y: 28.78))
        path.addCurve(to: CGPoint(x: 8.75, y: 27.85),
                      controlPoint1: CGPoint(x: 7.93, y: 29),
                      controlPoint2: CGPoint(x: 8.69, y: 28.08))
        path.addLine(to: CGPoint(x: 10.27, y: 22.33))
        path.addCurve(to: CGPoint(x: 7.2, y: 23.09),
                      controlPoint1: CGPoint(x: 9.23, y: 22.82),
                      controlPoint2: CGPoint(x: 8.2, y: 23.08))
        path.addCurve(to: CGPoint(x: 4.85, y: 21.06),
                      controlPoint1: CGPoint(x: 5.66, y: 23.09),
                      controlPoint2: CGPoint(x: 4.91, y: 22.27))
        path.addCurve(to: CGPoint(x: 6.73, y: 19.15),
                      controlPoint1: CGPoint(x: 4.87, y: 20.13),
                      controlPoint2: CGPoint(x: 5.39, y: 19.15))
        path.addCurve(to: CGPoint(x: 8.57, y: 20.85),
                      controlPoint1: CGPoint(x: 8.14, y: 19.15),
                      controlPoint2: CGPoint(x: 8.56, y: 20.15))
        path.addCurve(to: CGPoint(x: 8.39, y: 21.95),
                      controlPoint1: CGPoint(x: 8.56, y: 21.24),
                      controlPoint2: CGPoint(x: 8.52, y: 21.61))
        path.addCurve(to: CGPoint(x: 10.57, y: 20.77),
                      controlPoint1: CGPoint(x: 9.38, y: 22.15),
                      controlPoint2: CGPoint(x: 10.46, y: 21.1))
        path.addLine(to: CGPoint(x: 12.07, y: 15.58))
        path.addCurve(to: CGPoint(x: 9.17, y: 16.33),
                      controlPoint1: CGPoint(x: 11.12, y: 15.97),
                      controlPoint2: CGPoint(x: 10.16, y: 16.34))
        path.addCurve(to: CGPoint(x: 6.72, y: 14.23),
                      controlPoint1: CGPoint(x: 7.71, y: 16.32),
                      controlPoint2: CGPoint(x: 6.72, y: 15.38))
        path.addCurve(to: CGPoint(x: 8.52, y: 12.4),
                      controlPoint1: CGPoint(x: 6.72, y: 13.24),
                      controlPoint2: CGPoint(x: 7.47, y: 12.4))
        path.addCurve(to: CGPoint(x: 10.43, y: 14.08),
                      controlPoint1: CGPoint(x: 10.02, y: 12.39),
                      controlPoint2: CGPoint(x: 10.43, y: 13.38))
        path.addCurve(to: CGPoint(x: 10.19, y: 15.19),
                      controlPoint1: CGPoint(x: 10.42, y: 14.62),
                      controlPoint2: CGPoint(x: 10.31, y: 14.95))
        path.addCurve(to: CGPoint(x: 12.47, y: 14.1),
                      controlPoint1: CGPoint(x: 11.17, y: 15.33),
                      controlPoint2: CGPoint(x: 12.37, y: 14.39))
        path.addLine(to: CGPoint(x: 13.78, y: 9.09))
        path.addCurve(to: CGPoint(x: 11.04, y: 9.86),
                      controlPoint1: CGPoint(x: 12.97, y: 9.4),
                      controlPoint2: CGPoint(x: 12.15, y: 9.87))
        path.addCurve(to: CGPoint(x: 8.57, y: 7.82),
                      controlPoint1: CGPoint(x: 10.25, y: 9.86),
                      controlPoint2: CGPoint(x: 8.7, y: 9.65))
        path.addCurve(to: CGPoint(x: 10.35, y: 5.92),
                      controlPoint1: CGPoint(x: 8.54, y: 6.74),
                      controlPoint2: CGPoint(x: 9.45, y: 5.93))

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
