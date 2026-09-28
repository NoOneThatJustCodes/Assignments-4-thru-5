//
//  SingleCardView.swift
//  Assignment 4
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

struct SingleCardView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentModal: ToolbarSelection?
    @Binding var card: Card

    var body: some View {
        NavigationStack {
            CardDetailView(card: $card)
                .navigationTitle("Card")
                .navigationBarTitleDisplayMode(.inline)
                .modifier(CardToolbar(currentModal: $currentModal, card: $card))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") { dismiss() }
                    }
                }
        }
    }
}

struct SingleCardView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCardView(card: .constant(initialCards[0]))
            .environmentObject(CardStore(defaultData: true))
    }
}
