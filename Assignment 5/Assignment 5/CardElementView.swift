//
//  CardElementView.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

struct CardElementView: View {
    let element: CardElement
    let isSelected: Bool

    var body: some View {
        if let image = element as? ImageElement {
            ImageElementView(element: image, isSelected: isSelected)
        } else if let text = element as? TextElement {
            TextElementView(element: text, isSelected: isSelected)
        }
    }
}

struct ImageElementView: View {
    let element: ImageElement
    let isSelected: Bool

    var body: some View {
        Group {
            if let frameIndex = element.frameIndex,
               Shapes.shapes.indices.contains(frameIndex) {
                
                element.image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipShape(Shapes.shapes[frameIndex])
                    .contentShape(Shapes.shapes[frameIndex])
                
            } else {
                
                element.image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .overlay(
            Rectangle()
                .stroke(
                    isSelected ? Color.accentColor : Color.clear,
                    lineWidth: 5
                )
        )
        .contentShape(Rectangle())
    }
}

struct TextElementView: View {
    let element: TextElement
    let isSelected: Bool

    var body: some View {
        Text(element.text)
            .font(.custom(element.textFont, size: 180))
            .minimumScaleFactor(0.05)
            .lineLimit(4)
            .foregroundColor(element.textColor)
            .padding(20)
            .overlay(
                Rectangle()
                    .stroke(isSelected ? Color.accentColor : Color.clear, lineWidth: 5)
            )
    }
}
