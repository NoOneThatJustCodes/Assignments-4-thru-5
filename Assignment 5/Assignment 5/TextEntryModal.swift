//
//  TextEntryModal.swift
//  Assignment 5
//
//  Created by Jonathan S. on 10/2/26.
//

import SwiftUI

struct TextEntryModal: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var textElement: TextElement

    var body: some View {
        NavigationStack {
            TextField("Enter text", text: $textElement.text, onCommit: { dismiss() })
                .padding(20)
                .navigationTitle("Text")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") { dismiss() }
                    }
                }
        }
    }
}
