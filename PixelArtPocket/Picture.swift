//
//  Picture.swift
//  PixelArtPocket
//
//  Created by Tatsuya Tobioka on 2018/07/14.
//  Copyright © 2018 tnantoka. All rights reserved.
//

import UIKit

struct Picture: Codable {
    let createdAt: Date
    var dots = [Data]()
    var thumb: Data?

    init(colors: [UIColor]) {
        createdAt = Date()
        self.colors = colors
    }

    var colors: [UIColor] {
        get {
            return dots.map { NSKeyedUnarchiver.unarchiveObject(with: $0) as? UIColor }.flatMap { $0 }
        }
        set {
            dots = newValue.map { NSKeyedArchiver.archivedData(withRootObject: $0) }
        }
    }

    var image: UIImage? {
        get {
            guard let thumb = thumb else { return nil }
            return UIImage(data: thumb)
        }
        set {
            guard let newValue = newValue else { return }
            thumb = UIImagePNGRepresentation(newValue)
        }
    }

    func save() {
        let filename = "\(createdAt.timeIntervalSince1970).json"
        guard let data = try? JSONEncoder().encode(self) else { return }
        guard let json = String(data: data, encoding: .utf8) else { return }
        let path = Picture.docURL.appendingPathComponent(filename)
        try? json.write(to: path, atomically: true, encoding: .utf8)
    }

    static let fileManager = FileManager.default
    static let docURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

    static var all: [Picture] {
        guard let urls = try? fileManager.contentsOfDirectory(at: docURL, includingPropertiesForKeys: nil, options: []) else {
            return []
        }
        let pictures = urls.map { url -> Picture? in
            guard let data = try? Data(contentsOf: url) else { return nil }
            return try? JSONDecoder().decode(Picture.self, from: data)
        }
        return pictures.flatMap { $0 }
    }
}
