//
//  CardElement.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI
import UIKit

protocol CardElement {
    var id: UUID { get }
    var transform: Transform { get set }
}

extension CardElement {
    func index(in array: [CardElement]) -> Int? {
        array.firstIndex { $0.id == id }
    }
}

struct ImageElement: CardElement {
    var id = UUID()
    var transform = Transform()
    var uiImage: UIImage?
    var imageFilename: String?
    var frameIndex: Int?

    init(uiImage: UIImage? = nil, imageFilename: String? = nil, frameIndex: Int? = nil) {
        self.uiImage = uiImage
        self.imageFilename = imageFilename
        self.frameIndex = frameIndex
    }

    var image: Image {
        Image(uiImage: uiImage ?? UIImage.errorImage)
    }
}

extension ImageElement: Codable {
    enum CodingKeys: CodingKey { case id, transform, imageFilename, frameIndex }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID(uuidString: try container.decode(String.self, forKey: .id)) ?? UUID()
        transform = try container.decode(Transform.self, forKey: .transform)
        imageFilename = try container.decodeIfPresent(String.self, forKey: .imageFilename)
        frameIndex = try container.decodeIfPresent(Int.self, forKey: .frameIndex)
        if let imageFilename {
            uiImage = UIImage.load(uuidString: imageFilename)
        } else {
            uiImage = UIImage.errorImage
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id.uuidString, forKey: .id)
        try container.encode(transform, forKey: .transform)
        try container.encode(imageFilename, forKey: .imageFilename)
        try container.encode(frameIndex, forKey: .frameIndex)
    }
}

struct TextElement: CardElement {
    var id = UUID()
    var transform = Transform(size: CGSize(width: 500, height: 220))
    var text = ""
    var textColor = Color.black
    var textFont = "Gill Sans"
}

extension TextElement: Codable {
    enum CodingKeys: CodingKey { case id, transform, text, textFont }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID(uuidString: try container.decode(String.self, forKey: .id)) ?? UUID()
        transform = try container.decode(Transform.self, forKey: .transform)
        text = try container.decode(String.self, forKey: .text)
        textFont = try container.decode(String.self, forKey: .textFont)
        textColor = .black
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id.uuidString, forKey: .id)
        try container.encode(transform, forKey: .transform)
        try container.encode(text, forKey: .text)
        try container.encode(textFont, forKey: .textFont)
    }
}
