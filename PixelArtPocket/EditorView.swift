//
//  EditorView.swift
//  PixelArtPocket
//
//  Created by Tatsuya Tobioka on 2018/04/08.
//  Copyright © 2018 tnantoka. All rights reserved.
//

import UIKit

class EditorView: UIView {

    static let dotsPerRow: CGFloat = 32.0

    var dotLength: CGFloat {
        return bounds.width / EditorView.dotsPerRow
    }

    var dots = Array(repeating: UIColor.clear, count: Int(dotsPerRow * dotsPerRow))

    override func draw(_ rect: CGRect) {
        for (i, dotColor) in dots.enumerated() {
            guard dotColor != .clear else { continue }

            let dotRect = CGRect.init(
                x: CGFloat(i % Int(EditorView.dotsPerRow)) * dotLength,
                y: CGFloat(i / Int(EditorView.dotsPerRow)) * dotLength,
                width: dotLength,
                height: dotLength
            )
            let path = UIBezierPath(rect: dotRect)

            dotColor.setFill()
            path.fill()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addDot(touches)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        addDot(touches)
    }

    func addDot(_ touches: Set<UITouch>) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        let x = Int(floor(location.x / dotLength))
        let y = Int(floor(location.y / dotLength))
        dots[y * Int(EditorView.dotsPerRow) + x] = UIColor.black

        setNeedsDisplay()
    }
}