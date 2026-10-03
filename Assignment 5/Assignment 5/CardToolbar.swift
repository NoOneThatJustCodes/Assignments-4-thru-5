//
//  CardToolbar.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

struct CardToolbar: ViewModifier {
    @EnvironmentObject var store: CardStore
    @Binding var currentModal: ToolbarSelection?
    @Binding var card: Card
    @Binding var selectedElementIndex: Int?
    @State private var stickerImage: UIImage?
    @State private var photo: UIImage?
    @State private var frameIndex: Int?
    @State private var textElement = TextElement()

    private var selectedImageExists: Bool {
        guard let index = selectedElementIndex, card.elements.indices.contains(index) else { return false }
        return card.elements[index] is ImageElement
    }

    private var menu: some View {
        Menu {
            Button {
                if UIPasteboard.general.hasImages, let images = UIPasteboard.general.images {
                    for image in images { card.addElement(uiImage: image) }
                } else if UIPasteboard.general.hasStrings, let strings = UIPasteboard.general.strings {
                    for text in strings { card.addText(text) }
                }
            } label: {
                Label("Paste", systemImage: "doc.on.clipboard")
            }
            .disabled(!UIPasteboard.general.hasImages && !UIPasteboard.general.hasStrings)
        } label: {
            Label("Add", systemImage: "ellipsis.circle")
        }
    }

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    PasteButton(payloadType: CustomTransfer.self) { items in
                        Task {
                            card.addElements(from: items)
                        }
                    }
                    .labelStyle(.iconOnly)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    menu
                }
                ToolbarItem(placement: .bottomBar) {
                    BottomToolbar(modal: $currentModal, framesEnabled: selectedImageExists)
                }
            }
            .sheet(item: $currentModal) { modal in
                switch modal {
                case .photoModal:
                    PhotoModal(photo: $photo)
                        .onDisappear {
                            if let photo {
                                card.addElement(uiImage: photo)
                            }
                            photo = nil
                        }
                case .frameModal:
                    FrameModal(frameIndex: $frameIndex)
                        .onDisappear {
                            if let frameIndex, let selectedElementIndex,
                               card.elements.indices.contains(selectedElementIndex) {
                                card.update(card.elements[selectedElementIndex], frameIndex: frameIndex)
                            }
                            frameIndex = nil
                        }
                case .stickerModal:
                    StickerModal(stickerImage: $stickerImage)
                        .onDisappear {
                            if let stickerImage {
                                card.addElement(uiImage: stickerImage)
                            }
                            stickerImage = nil
                        }
                case .textModal:
                    TextEntryModal(textElement: $textElement)
                        .onDisappear {
                            if !textElement.text.isEmpty {
                                card.addText(textElement.text)
                            }
                            textElement = TextElement()
                        }
                }
            }
            .onChange(of: currentModal) { newValue in
                if newValue == .frameModal && !selectedImageExists {
                    currentModal = nil
                }
            }
    }
}
