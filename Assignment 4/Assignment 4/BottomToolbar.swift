//
//  BottomToolbar.swift
//  Assignment 4
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

struct ToolbarButton: View {
    let modal: ToolbarSelection

    private let modalButton: [ToolbarSelection: (text: String, imageName: String)] = [
        .photoModal: ("Photos", "photo"),
        .frameModal: ("Frames", "square.on.circle"),
        .stickerModal: ("Stickers", "heart.circle"),
        .textModal: ("Text", "textformat")
    ]

    var body: some View {
        if let button = modalButton[modal] {
            VStack(spacing: 2) {
                Image(systemName: button.imageName)
                    .font(.title2)
                Text(button.text)
                    .font(.caption)
            }
            .padding(.top, 4)
        }
    }
}

struct BottomToolbar: View {
    @Binding var modal: ToolbarSelection?

    var body: some View {
        HStack {
            ForEach(ToolbarSelection.allCases, id: \.self) { selection in
                Button { modal = selection } label: {
                    ToolbarButton(modal: selection)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct BottomToolbar_Previews: PreviewProvider {
    static var previews: some View {
        BottomToolbar(modal: .constant(.stickerModal))
            .padding()
    }
}
