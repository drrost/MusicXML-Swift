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

    func update(_ aScorePartwise: ScorePartwise) {
        scorePartwise = aScorePartwise
    }

    override func draw(_ rect: CGRect) {
        guard scorePartwise != nil else { return }

        guard let context = UIGraphicsGetCurrentContext() else { return }
        drawText(context: context,
                 text: scorePartwise.partList.scorePart.partName.partNameText)
        drawStaff(context: context)
    }

    // MARK: - Private API

    fileprivate func drawText(context: CGContext, text: String) {

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

    fileprivate func drawStaff(context: CGContext) {

        translate(context: context)

        let kStaffSpace: CGFloat = 10.0
        let kStaffLineWidth: CGFloat = 1.0
        let kTopOffset: CGFloat =  20.0
        let kSideOffset: CGFloat = 10.0
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(kStaffLineWidth)

        for i in 1...5 {
            let y = kTopOffset + CGFloat(i) * kStaffSpace
            context.move(to: CGPoint(x: kSideOffset, y: y))
            context.addLine(to: CGPoint(x: frame.size.width - kSideOffset, y: y))
            context.drawPath(using: .fillStroke)
        }
    }

    fileprivate func translate(context: CGContext) {
        context.textMatrix = .identity
        context.translateBy(x: 0, y: bounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
    }
}
