//
//  StickerModal.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

struct StickerModal: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var stickerImage: UIImage?

    private let columns = [GridItem(.adaptive(minimum: 120), spacing: 10)]
    private let stickers: [String]

    init(stickerImage: Binding<UIImage?>) {
        self._stickerImage = stickerImage
        self.stickers = StickerModal.loadStickers()
    }

    static func loadStickers() -> [String] {
        var themes: [URL] = []
        var stickerNames: [String] = []
        let fileManager = FileManager.default

        if let resourcePath = Bundle.main.resourcePath,
           let enumerator = fileManager.enumerator(
                at: URL(fileURLWithPath: resourcePath + "/Stickers"),
                includingPropertiesForKeys: nil,
                options: [.skipsSubdirectoryDescendants, .skipsHiddenFiles]) {
            for case let url as URL in enumerator where url.hasDirectoryPath {
                themes.append(url)
            }
        }

        for theme in themes {
            if let files = try? fileManager.contentsOfDirectory(atPath: theme.path) {
                for file in files {
                    stickerNames.append(theme.path + "/" + file)
                }
            }
        }
        return stickerNames.sorted()
    }

    private func image(from path: String) -> UIImage {
        UIImage(contentsOfFile: path) ?? UIImage(systemName: "photo") ?? UIImage()
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(stickers, id: \.self) { sticker in
                        Image(uiImage: image(from: sticker))
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 100, maxHeight: 100)
                            .padding()
                            .onTapGesture {
                                stickerImage = image(from: sticker)
                                dismiss()
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Stickers")
        }
    }
}

struct StickerModal_Previews: PreviewProvider {
    static var previews: some View {
        StickerModal(stickerImage: .constant(nil))
    }
}
