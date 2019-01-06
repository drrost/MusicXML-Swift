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

    func update(_ aScorePartwise: ScorePartwise) {
        scorePartwise = aScorePartwise
    }

    override func draw(_ rect: CGRect) {
        guard scorePartwise != nil else { return }

        guard let context = UIGraphicsGetCurrentContext() else { return }
        drawText(context: context,
                 text: scorePartwise.partList.scorePart.partName.partNameText)
    }

    fileprivate func drawText(context: CGContext, text: String) {
        context.textMatrix = .identity
        context.translateBy(x: 0, y: bounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)

        let path = CGMutablePath()
        path.addRect(bounds)

        let attrString = NSAttributedString(string: text)

        let framesetter = CTFramesetterCreateWithAttributedString(
            attrString as CFAttributedString)

        let frame = CTFramesetterCreateFrame(
            framesetter, CFRangeMake(0, attrString.length), path, nil)

        CTFrameDraw(frame, context)
    }
}
