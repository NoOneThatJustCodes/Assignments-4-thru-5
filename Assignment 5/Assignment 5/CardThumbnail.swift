//
//  CardThumbnail.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

struct CardThumbnail: View {
    let card: Card

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(card.backgroundColor)
                .shadow(radius: 4)

            VStack(spacing: 8) {
                ForEach(card.elements.prefix(3), id: \.id) { element in
                    CardElementView(element: element, isSelected: false)
                        .frame(maxWidth: 120, maxHeight: 75)
                }
            }
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
