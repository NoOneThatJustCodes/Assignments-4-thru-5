//
//  CardDetailView.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

struct CardDetailView: View {
    @Binding var card: Card
    @Binding var selectedElementIndex: Int?
    var viewScale: CGFloat = 1

    var body: some View {
        ZStack {
            card.backgroundColor
                .frame(width: Settings.cardSize.width, height: Settings.cardSize.height)

            ForEach(card.elements.indices, id: \.self) { index in
                CardElementView(
                    element: card.elements[index],
                    isSelected: selectedElementIndex == index
                )
                .resizableView(
                    transform: $card.elements[index].transform,
                    viewScale: viewScale
                )
                .elementContextMenu(card: $card, element: card.elements[index])
                .onTapGesture {
                    selectedElementIndex = index
                }
            }
        }
        .frame(width: Settings.cardSize.width, height: Settings.cardSize.height)
        .clipped()
        .dropDestination(for: CustomTransfer.self) { items, _ in
            card.addElements(from: items)
            return !items.isEmpty
        }
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(card: .constant(initialCards[0]), selectedElementIndex: .constant(nil))
            .scaleEffect(0.3)
    }
}
