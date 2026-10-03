//
//  Settings.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/30/26.
//

import SwiftUI

struct Settings {
    static let thumbnailSize = CGSize(width: 150, height: 250)
    static let defaultElementSize = CGSize(width: 800, height: 800)
    static let cardSize = CGSize(width: 1300, height: 2000)

    static func calculateScale(_ size: CGSize) -> CGFloat {
        min(size.width / cardSize.width, size.height / cardSize.height)
    }
}
