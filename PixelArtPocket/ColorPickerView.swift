//
//  ColorPickerView.swift
//  PixelArtPocket
//
//  Created by Tatsuya Tobioka on 2018/06/01.
//  Copyright © 2018 tnantoka. All rights reserved.
//

import UIKit

// https://stackoverflow.com/questions/27208386/simple-swift-color-picker-popover-ios

protocol ColorPickerDelegate: class{
    func colorDidChange(color: UIColor)
}

class ColorPickerView: UIView {

    weak var delegate: ColorPickerDelegate?

    let saturationExponentTop:Float = 2.0
    let saturationExponentBottom:Float = 1.3

    var elementSize: CGFloat = 16.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        self.clipsToBounds = true
        let touchGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.touchedColor(gestureRecognizer:)))
        touchGesture.minimumPressDuration = 0
        touchGesture.allowableMovement = CGFloat.greatestFiniteMagnitude
        self.addGestureRecognizer(touchGesture)
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        for y in stride(from: CGFloat(0), to: rect.height, by: elementSize) {

            var saturation = y < rect.height / 2.0 ? CGFloat(2 * y) / rect.height : 2.0 * CGFloat(rect.height - y) / rect.height
            saturation = CGFloat(powf(Float(saturation), y < rect.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
            let brightness = y < rect.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(rect.height - y) / rect.height

            for x in stride(from: (0 as CGFloat), to: rect.width, by: elementSize) {
                let hue = x / rect.width

                let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)

                context!.setFillColor(color.cgColor)
                context!.fill(CGRect(x:x, y: y + rect.origin.y,
                                     width: elementSize, height: elementSize))
            }
        }
    }

    func getColorAtPoint(point: CGPoint) -> UIColor {
        let roundedPoint = CGPoint(x:elementSize * CGFloat(Int(point.x / elementSize)),
                                   y:elementSize * CGFloat(Int(point.y / elementSize)))

        let hue = roundedPoint.x / bounds.width

        var saturation = roundedPoint.y < bounds.height / 2.0 ? CGFloat(2 * roundedPoint.y) / bounds.height
            : 2.0 * CGFloat(bounds.height - roundedPoint.y) / bounds.height
        saturation = CGFloat(powf(Float(saturation), roundedPoint.y < bounds.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
        let brightness = roundedPoint.y < bounds.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(bounds.height - roundedPoint.y) / bounds.height

        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }

    @objc func touchedColor(gestureRecognizer: UILongPressGestureRecognizer){
        guard gestureRecognizer.state == .began else { return }

        let point = gestureRecognizer.location(in: self)
        let color = getColorAtPoint(point: point)

        self.delegate?.colorDidChange(color: color)
    }
}
