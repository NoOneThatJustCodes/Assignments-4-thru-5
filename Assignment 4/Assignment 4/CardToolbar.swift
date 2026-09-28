//
//  CardToolbar.swift
//  Assignment 4
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

struct CardToolbar: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    @Binding var currentModal: ToolbarSelection?
    @Binding var card: Card
    @State private var stickerImage: UIImage?

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    BottomToolbar(modal: $currentModal)
                }
            }
            .sheet(item: $currentModal) { modal in
                switch modal {
                case .stickerModal:
                    StickerModal(stickerImage: $stickerImage)
                        .onDisappear {
                            if let stickerImage {
                                card.addElement(uiImage: stickerImage)
                            }
                            stickerImage = nil
                        }
                case .photoModal:
                    PlaceholderModal(title: "Photos", message: "Photo importing is introduced in Chapter 17.")
                case .frameModal:
                    PlaceholderModal(title: "Frames", message: "Custom frames are introduced in Chapter 18.")
                case .textModal:
                    TextEntryModal(card: $card)
                }
            }
    }
}

struct PlaceholderModal: View {
    @Environment(\.dismiss) private var dismiss
    let title: String
    let message: String

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "square.dashed")
                    .font(.largeTitle)

                Text(title)
                    .font(.headline)

                Text(message)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
            .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) { Button("Done") { dismiss() } }
                }
        }
    }
}

struct TextEntryModal: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var card: Card
    @State private var text = ""

    var body: some View {
        NavigationStack {
            Form { TextField("Text", text: $text) }
                .navigationTitle("Text")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            if !text.isEmpty { card.addText(text) }
                            dismiss()
                        }
                    }
                }
        }
    }
}
