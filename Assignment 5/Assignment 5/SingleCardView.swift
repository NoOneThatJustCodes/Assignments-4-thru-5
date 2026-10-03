//
//  SingleCardView.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

struct SingleCardView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var store: CardStore
    @State private var currentModal: ToolbarSelection?
    @State private var selectedElementIndex: Int?
    @Binding var card: Card

    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                CardDetailView(
                    card: $card,
                    selectedElementIndex: $selectedElementIndex,
                    viewScale: Settings.calculateScale(proxy.size)
                )
                .scaleEffect(Settings.calculateScale(proxy.size))
                .frame(width: proxy.size.width, height: proxy.size.height)
                .clipped()
                .onDisappear {
                    card.save()
                }
                .navigationTitle("Card")
                .navigationBarTitleDisplayMode(.inline)
                .modifier(
                    CardToolbar(
                        currentModal: $currentModal,
                        card: $card,
                        selectedElementIndex: $selectedElementIndex
                    )
                )
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            card.save()
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
