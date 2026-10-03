//
//  ColorExtensions.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/30/26.
//

import SwiftUI

extension Color {
    static var background: Color { Color(UIColor.systemGroupedBackground) }
    static var bar: Color { Color(UIColor.secondarySystemBackground) }

    static func random() -> Color {
        Color(
            red: Double.random(in: 0.55...0.95),
            green: Double.random(in: 0.55...0.95),
            blue: Double.random(in: 0.55...0.95)
        )
    }

    func components() -> [CGFloat] {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return [red, green, blue, alpha]
    }

    static func color(components: [CGFloat]) -> Color {
        guard components.count >= 4 else { return .yellow }
        return Color(red: components[0], green: components[1], blue: components[2], opacity: components[3])
    }
}
