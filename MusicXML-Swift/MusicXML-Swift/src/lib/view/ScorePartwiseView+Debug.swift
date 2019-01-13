//
//  ScorePartwiseView+Debug.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/13/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import UIKit

extension ScorePartwiseView {

    func debugDrawCircle(_ point: CGPoint, _ context: CGContext) {
        let radius: CGFloat = 0.5
        let rect = CGRect(x: point.x - radius,
                          y: point.y - radius,
                          width: radius * 2.0, height: radius * 2.0)
        context.saveGState()
        let path = UIBezierPath(ovalIn: rect)
        UIColor.red.setFill()
        path.fill()
        context.restoreGState()
    }

    func debugDrawPoint(_ point: CGPoint, _ context: CGContext) {
        context.saveGState()
        let rect = CGRect(x: point.x, y: point.y, width: 0.5, height: 0.5)
        UIColor.red.setFill()
        context.fill(rect)
        context.restoreGState()
    }

}
