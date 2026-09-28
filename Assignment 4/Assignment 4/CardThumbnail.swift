//
//  CardThumbnail.swift
//  Assignment 4
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
            VStack {
                Text("CARD")
                    .font(.headline)
                ForEach(card.elements.prefix(2), id: \.id) { element in
                    CardElementView(element: element)
                        .frame(maxWidth: 100, maxHeight: 80)
                }
            }
            .padding()
        }
        .frame(width: 150, height: 250)
    }
}
