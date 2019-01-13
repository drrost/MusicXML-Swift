//
//  ScorePartwiseView+Time.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/7/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import UIKit

extension ScorePartwiseView {

    static let kTimeTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 22.0)!]

    func draw(time: Time, context: CGContext, point: CGPoint, scale: CGFloat = 1) {

        context.saveGState()
        context.translateBy(x: point.x, y: point.y)
        context.scaleBy(x: scale, y: scale)

        translate(context: context)

        context.translateBy(x: 0.0, y: 4.5)
        draw(text: time.beats, context: context)

        context.translateBy(x: 0.0, y: -18.0)
        draw(text: time.beatType, context: context)

        context.restoreGState()
    }

    fileprivate func draw(text: String, context: CGContext) {
        let path = CGMutablePath()
        path.addRect(bounds)

        let attrString = NSAttributedString(
            string: text, attributes: ScorePartwiseView.kTimeTextAttributes)

        let framesetter = CTFramesetterCreateWithAttributedString(
            attrString as CFAttributedString)

        let frame = CTFramesetterCreateFrame(
            framesetter, CFRangeMake(0, attrString.length), path, nil)

        CTFrameDraw(frame, context)
    }
}
