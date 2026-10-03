//
//  CustomTransfer.swift
//  Assignment 5
//
//  Created by Jonathan S. on 10/2/26.
//

import SwiftUI
import UniformTypeIdentifiers

struct CustomTransfer: Transferable {
    var image: UIImage?
    var text: String?

    init(image: UIImage? = nil, text: String? = nil) {
        self.image = image
        self.text = text
    }

    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            CustomTransfer(image: UIImage(data: data))
        }
        DataRepresentation(importedContentType: .text) { data in
            CustomTransfer(text: String(decoding: data, as: UTF8.self))
        }
    }
}

extension Card {
    mutating func addElements(from transfer: [CustomTransfer]) {
        for item in transfer {
            if let text = item.text, !text.isEmpty {
                addText(text)
            } else if let image = item.image {
                addElement(uiImage: image)
            }
        }
    }
}
