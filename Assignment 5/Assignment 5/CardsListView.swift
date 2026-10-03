//
//  CardsListView.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

struct CardsListView: View {
    @EnvironmentObject var store: CardStore
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @State private var selectedCard: Card?

    private var thumbnailSize: CGSize {
        var scale: CGFloat = 1
        if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            scale = 1.5
        }
        return CGSize(width: Settings.thumbnailSize.width * scale,
                      height: Settings.thumbnailSize.height * scale)
    }

    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: thumbnailSize.width), spacing: 30)]
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if store.cards.isEmpty {
                    Spacer()
                    Button {
                        selectedCard = store.addCard()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 70))
                    }
                    .accessibilityLabel("Create new card")
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 30) {
                            ForEach(store.cards) { card in
                                CardThumbnail(card: card)
                                    .frame(width: thumbnailSize.width, height: thumbnailSize.height)
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            store.remove(card)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                    .onTapGesture { selectedCard = card }
                            }
                        }
                        .padding(.top, 20)
                        .padding(.horizontal)
                    }
                }

                Button {
                    selectedCard = store.addCard()
                } label: {
                    Label("Create New", systemImage: "plus")
                        .font(.system(size: 16, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                }
                .background(Color.bar)
            }
            .background(Color.background.ignoresSafeArea())
            .navigationTitle("Cards")
            .fullScreenCover(item: $selectedCard) { card in
                if let index = store.index(for: card) {
                    SingleCardView(card: $store.cards[index])
                        .environmentObject(store)
                } else {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                        Text("Card not found")
                            .font(.headline)
                        Button("Close") { selectedCard = nil }
                    }
                }
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .inactive {
                    store.saveAll()
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
