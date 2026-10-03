//
//  ElementContextMenu.swift
//  Assignment 5
//
//  Created by Jonathan S. on 10/2/26.
//

import SwiftUI

struct ElementContextMenu: ViewModifier {
    @Binding var card: Card
    let element: CardElement

    func body(content: Content) -> some View {
        content.contextMenu {
            Button {
                if let text = element as? TextElement {
                    UIPasteboard.general.string = text.text
                } else if let image = element as? ImageElement {
                    UIPasteboard.general.image = image.uiImage
                }
            } label: {
                Label("Copy", systemImage: "doc.on.doc")
            }

            Button(role: .destructive) {
                card.remove(element)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

extension View {
    func elementContextMenu(card: Binding<Card>, element: CardElement) -> some View {
        modifier(ElementContextMenu(card: card, element: element))
    }
}
