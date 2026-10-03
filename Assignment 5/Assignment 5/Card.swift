//
//  Card.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI
import UIKit

struct Card: Identifiable {
    var id = UUID()
    var backgroundColor: Color = .yellow
    var elements: [CardElement] = []

    mutating func addElement(uiImage: UIImage) {
        let image = uiImage.resized()
        let filename = image.save()
        elements.append(ImageElement(uiImage: image, imageFilename: filename))
        save()
    }

    mutating func addText(_ text: String) {
        guard !text.isEmpty else { return }
        elements.append(TextElement(text: text))
        save()
    }

    mutating func remove(_ element: CardElement) {
        if let index = element.index(in: elements) {
            if let imageElement = element as? ImageElement, let filename = imageElement.imageFilename {
                try? FileManager.default.removeItem(at: URL.documentsDirectory.appendingPathComponent(filename))
            }
            elements.remove(at: index)
            save()
        }
    }

    mutating func update(_ element: CardElement?, frameIndex: Int) {
        guard let element,
              let index = element.index(in: elements),
              var imageElement = elements[index] as? ImageElement else { return }
        imageElement.frameIndex = frameIndex
        elements[index] = imageElement
        save()
    }

    func save() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            let url = URL.documentsDirectory.appendingPathComponent("\(id).rwcard")
            try data.write(to: url)
        } catch {
            print("Card save error:", error.localizedDescription)
        }
    }
}

extension Card: Codable {
    enum CodingKeys: CodingKey { case id, backgroundColor, imageElements, textElements }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID(uuidString: try container.decode(String.self, forKey: .id)) ?? UUID()
        let components = try container.decodeIfPresent([CGFloat].self, forKey: .backgroundColor) ?? [1, 1, 0, 1]
        backgroundColor = .color(components: components)
        elements = []
        elements += try container.decodeIfPresent([ImageElement].self, forKey: .imageElements) ?? []
        elements += try container.decodeIfPresent([TextElement].self, forKey: .textElements) ?? []
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id.uuidString, forKey: .id)
        try container.encode(backgroundColor.components(), forKey: .backgroundColor)
        try container.encode(elements.compactMap { $0 as? ImageElement }, forKey: .imageElements)
        try container.encode(elements.compactMap { $0 as? TextElement }, forKey: .textElements)
    }
}
