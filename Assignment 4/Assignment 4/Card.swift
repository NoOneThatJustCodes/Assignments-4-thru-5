//
//  Card.swift
//  Assignment 4
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    var backgroundColor: Color = .yellow
    var elements: [CardElement] = []

    mutating func addElement(uiImage: UIImage) {
        elements.append(ImageElement(uiImage: uiImage))
    }

    mutating func addText(_ text: String) {
        elements.append(TextElement(text: text))
    }
}
