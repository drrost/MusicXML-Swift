//
//  ScorePartwiseView.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/6/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import UIKit

let kStaffSpace: CGFloat = 9.0
let kStaffLineWidth: CGFloat = 1.0
let kDistanceBetweenNotesY: CGFloat = (kStaffSpace + kStaffLineWidth ) / 2.0
let kStaffTopOffset: CGFloat = 30.0
let kStaffSideOffset: CGFloat = 10.0
let kLinesNumber: Int = 5

class ScorePartwiseView: UIView {

    fileprivate var scorePartwise: ScorePartwise!

    fileprivate let color = UIColor.black

    fileprivate var context: CGContext!

    // MARK: - Public API

    func update(_ scorePartwise: ScorePartwise) {
        self.scorePartwise = scorePartwise
    }

    // MARK: - From base clsses

    override func draw(_ rect: CGRect) {

        context = UIGraphicsGetCurrentContext()
        guard scorePartwise != nil, context != nil else { return }

        handleBackgroundObjects()
        handleMeasures()

        closeLastStaff(context)
    }

    // MARK: - Private

    fileprivate func handleBackgroundObjects() {

        let partName = scorePartwise.partList.scorePart.partName.partNameText ?? ""
        draw(partName: partName, on: context)
        drawStaff(context)
    }

    fileprivate func handleMeasures() {

        let measures = scorePartwise.part.measures
        guard !measures.isEmpty else { return }

        handleMeasuresAttributes(measures)
        handleMeasuresContent(measures)
    }

    fileprivate func handleMeasuresAttributes(_ measures: [Measure]) {

        if let attributes = measures[0].attributes {
            handleClef(attributes.clef)
            handleTime(attributes.time)
        }
    }

    fileprivate func handleClef(_ clef: Clef?) {

        guard let clef = clef else { return }

        let kClefSideOffset: CGFloat = 15.0
        draw(clef: clef, context,
             point: CGPoint(x: kClefSideOffset, y: kStaffTopOffset - 6.0))
    }

    fileprivate func handleTime(_ time: Time?) {

        guard let time = time else { return }

        draw(time: time,
             context: context,
             point: CGPoint(x: kStaffSideOffset + 35.0, y: kStaffTopOffset))
    }

    fileprivate func handleMeasuresContent(_ measures: [Measure]) {

        var point = CGPoint(
            x: 70.0, y: kStaffTopOffset + CGFloat(kLinesNumber - 1) * kStaffSpace)

        let count = measures.count

        for (i, measure) in measures.enumerated() {
            let shouldDrawLastClose = i == count - 1
            let lastX = draw(measure: measure,
                             context: context,
                             startPoint: point,
                             drawLastClose: shouldDrawLastClose)
            point.x = lastX + 60.0
        }
    }

    // MARK: - Drawing (working with CGContext)

    fileprivate func draw(partName: String, on context: CGContext) {

        translate(context: context)

        let path = CGMutablePath()
        path.addRect(bounds)

        let attrString = NSAttributedString(string: partName)

        let frameSetter = CTFramesetterCreateWithAttributedString(
            attrString as CFAttributedString)

        let frame = CTFramesetterCreateFrame(
            frameSetter, CFRangeMake(0, attrString.length), path, nil)

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
