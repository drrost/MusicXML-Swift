//
//  ScorePartwiseView.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/6/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import UIKit

class ScorePartwiseView: UIView {

    fileprivate var scorePartwise: ScorePartwise!

    fileprivate let color = UIColor.black
    let kStaffSpace: CGFloat = 10.0
    let kStaffLineWidth: CGFloat = 1.0
    let kStaffTopOffset: CGFloat = 30.0
    let kStaffSideOffset: CGFloat = 10.0
    let kLinesNumber: Int = 5

    // MARK: - Public API

    func update(_ aScorePartwise: ScorePartwise) {
        scorePartwise = aScorePartwise
    }

    // MARK: - From base clsses

    override func draw(_ rect: CGRect) {
        guard scorePartwise != nil else { return }

        guard let context = UIGraphicsGetCurrentContext() else { return }
        drawText(context,
                 text: scorePartwise.partList.scorePart.partName.partNameText)
        drawStaff(context)

        let measures = scorePartwise.part.measures
        guard measures.count > 0 else { return }

        if let attributes = measures[0].attributes {
            if let clef = attributes.clef {
                let kClefSideOffset: CGFloat = 15.0
                draw(clef: clef, context, scale: 1.4,
                     point: CGPoint(x: kClefSideOffset, y: kStaffTopOffset - 6.0))
            }

            draw(time: attributes.time,
                 context: context,
                 point: CGPoint(x: kStaffSideOffset + 35.0, y: kStaffTopOffset))
        }

        let notesYStart = kStaffTopOffset + CGFloat(kLinesNumber - 1) * kStaffSpace
        draw(note: measures[0].note, context: context,
             point: CGPoint(x: 70.0, y: notesYStart + 2.0))

        closeLastStaff(context)
    }

    // MARK: - Private API

    fileprivate func drawText(_ context: CGContext, text: String) {

        translate(context: context)

        let path = CGMutablePath()
        path.addRect(bounds)

        let attrString = NSAttributedString(string: text)

        let framesetter = CTFramesetterCreateWithAttributedString(
            attrString as CFAttributedString)

        let frame = CTFramesetterCreateFrame(
            framesetter, CFRangeMake(0, attrString.length), path, nil)

        CTFrameDraw(frame, context)
    }

    fileprivate func drawStaff(_ context: CGContext) {

        translate(context: context)

        context.setStrokeColor(color.cgColor)
        context.setLineWidth(kStaffLineWidth)

        for i in 0...kLinesNumber-1 {
            let y = kStaffTopOffset + CGFloat(i) * kStaffSpace
            context.move(to: CGPoint(x: kStaffSideOffset, y: y))
            context.addLine(to: CGPoint(x: frame.size.width - kStaffSideOffset, y: y))
            context.drawPath(using: .fillStroke)
        }
    }

    fileprivate func closeLastStaff(_ context: CGContext) {

        let kRectWidth: CGFloat = 3.0

        let x: CGFloat = frame.size.width - kStaffSideOffset - kRectWidth
        let y: CGFloat = CGFloat(kLinesNumber - 1) * kStaffSpace
        context.addRect(
            CGRect(x: x, y: kStaffTopOffset, width: kRectWidth, height: y))

        let xCloseLine: CGFloat = x - 3.0
        context.move(to: CGPoint(x: xCloseLine, y: kStaffTopOffset))
        context.addLine(to: CGPoint(x: xCloseLine, y: y + kStaffTopOffset))

        context.drawPath(using: .fillStroke)
    }

    public func translate(context: CGContext) {
        context.textMatrix = .identity
        context.translateBy(x: 0, y: bounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
    }
}
