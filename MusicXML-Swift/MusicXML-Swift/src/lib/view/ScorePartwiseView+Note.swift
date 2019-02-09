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

        guard note.isRest == false else { return }

        context.saveGState()
        context.translateBy(x: 0.0, y: shiftForNote(note))

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
}
