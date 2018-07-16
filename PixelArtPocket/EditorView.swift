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
    static let defaultDots = Array(repeating: UIColor.clear, count: Int(dotsPerRow * dotsPerRow))

    let dotsUndoManager = UndoManager()
    var canUndo: Bool {
        return dotsUndoManager.canUndo
    }
    var canRedo: Bool {
        return dotsUndoManager.canRedo
    }

    var dotLength: CGFloat {
        return bounds.width / EditorView.dotsPerRow
    }

    var dots = defaultDots

    var isGrid = false {
        didSet {
            setNeedsDisplay()
        }
    }
    var color = UIColor.black
    var dotsDidChange: () -> Void = {}

    var screenshot: UIImage? {
        let size = bounds.size
        let opaque = true
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)

        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }

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

        if isGrid {
            for i in 1..<Int(EditorView.dotsPerRow) {
                let step = dotLength * CGFloat(i)

                let path = UIBezierPath()

                path.move(to: CGPoint(x: step, y: 0.0))
                path.addLine(to: CGPoint(x: step, y: rect.maxY))

                path.move(to: CGPoint(x: 0.0, y: step))
                path.addLine(to: CGPoint(x: rect.maxX, y: step))

                UIColor.lightGray.setStroke()
                path.stroke()
            }
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
        let i = y * Int(EditorView.dotsPerRow) + x

        setColor(color, atIndex: i)

        setNeedsDisplay()
        dotsDidChange()
    }

    func setColor(_ color: UIColor, atIndex index: Int) {
        guard index < dots.count else { return }
        let prevColor = dots[index]
        if color != prevColor {
            dots[index] = color
            dotsUndoManager.registerUndo(withTarget: self) { $0.setColor(prevColor, atIndex: index) }
        }
    }

    func undo() {
        dotsUndoManager.undo()
        setNeedsDisplay()
        dotsDidChange()
    }

    func redo() {
        dotsUndoManager.redo()
        setNeedsDisplay()
        dotsDidChange()
    }
}
