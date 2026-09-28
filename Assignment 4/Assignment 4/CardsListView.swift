//
//  CardsListView.swift
//  Assignment 4
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

struct CardsListView: View {
    @EnvironmentObject var store: CardStore
    @State private var selectedCard: Card?

    private let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 20)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(store.cards) { card in
                        CardThumbnail(card: card)
                            .onTapGesture {
                                selectedCard = card
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Cards")
            .background(Color(uiColor: .systemGroupedBackground))
            .fullScreenCover(item: $selectedCard) { card in
                if let index = store.index(for: card) {
                    SingleCardView(card: $store.cards[index])
                } else {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)

                        Text("Card not found")
                            .font(.headline)

                        Button("Close") {
                            selectedCard = nil
                        }
                    }
                }
            }
        }
    }
}

struct CardsListView_Previews: PreviewProvider {
    static var previews: some View {
        CardsListView()
            .environmentObject(CardStore(defaultData: true))
    }
}
