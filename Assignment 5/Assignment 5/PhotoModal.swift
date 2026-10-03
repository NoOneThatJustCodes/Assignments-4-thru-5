//
//  PhotoModal.swift
//  Assignment 5
//
//  Created by Jonathan S. on 10/1/26.
//

import SwiftUI
import PhotosUI
import UniformTypeIdentifiers

struct PhotoModal: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var photo: UIImage?
    @State private var selection: PhotosPickerItem?

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                PhotosPicker(selection: $selection, matching: .images) {
                    Label("Choose Photo", systemImage: "photo.on.rectangle")
                        .font(.headline)
                        .padding()
                }

                if let photo {
                    Image(uiImage: photo)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 320, maxHeight: 320)
                } else {
                    Text("Choose a photo from your library.")
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .navigationTitle("Photos")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") { dismiss() }
                        .disabled(photo == nil)
                }
            }
            .task(id: selection) {
                guard let selection else { return }
                if let data = try? await selection.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    photo = image
                }
            }
        }
    }
}
