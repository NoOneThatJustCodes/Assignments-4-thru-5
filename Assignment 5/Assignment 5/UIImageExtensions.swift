//
//  UIImageExtensions.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/30/26.
//

import UIKit

extension URL {
    static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

extension UIImage {
    static var errorImage: UIImage {
        UIImage(systemName: "photo") ?? UIImage()
    }

    func save() -> String? {
        let filename = UUID().uuidString
        let url = URL.documentsDirectory.appendingPathComponent(filename)
        guard let data = pngData() else { return nil }
        do {
            try data.write(to: url)
            return filename
        } catch {
            print("Image save error:", error.localizedDescription)
            return nil
        }
    }

    static func load(uuidString: String) -> UIImage {
        let url = URL.documentsDirectory.appendingPathComponent(uuidString)
        return UIImage(contentsOfFile: url.path) ?? .errorImage
    }

    func resized(maxDimension: CGFloat = 1200) -> UIImage {
        let longest = max(size.width, size.height)
        guard longest > maxDimension, longest > 0 else { return self }
        let scale = maxDimension / longest
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
