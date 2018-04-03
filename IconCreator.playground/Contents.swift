//: Playground - noun: a place where people can play

import UIKit

CreatorConfiguration.loadFont(name: "JF-Dot-K14B.ttf")

let iconCreator = IconCreator()
iconCreator.config.fontName = "JF Dot K14"

iconCreator.lengths = [120.0, 180.0, 1024.0]
iconCreator.config.string = "P"
iconCreator.config.fontSizeScaleY = 0.74
iconCreator.config.backgroundColor = UIColor(red: 0.0 / 255.0, green: 150.0 / 255.0, blue: 136.0 / 255.0, alpha: 1.0)
iconCreator.config.textColor = .white

// iconCreator.config.grid = .preview
iconCreator.config.gridColor = .green

iconCreator.preview().first // Preview

iconCreator.save()
print("$ open \(iconCreator.rootPath)")
