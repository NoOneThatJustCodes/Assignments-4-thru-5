//
//  CardDetailView.swift
//  Assignment 4
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

struct CardDetailView: View {
    @Binding var card: Card

    var body: some View {
        ZStack {
            card.backgroundColor
                .ignoresSafeArea()

            ForEach(card.elements.indices, id: \.self) { index in
                CardElementView(element: card.elements[index])
                    .resizableView(transform: $card.elements[index].transform)
            }
        }
        .clipped()
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(card: .constant(initialCards[0]))
    }
}
