//
//  CardStore.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

final class CardStore: ObservableObject {
    @Published var cards: [Card] = []

    init(defaultData: Bool = false) {
        cards = defaultData ? initialCards : load()
    }

    func index(for card: Card) -> Int? {
        cards.firstIndex { $0.id == card.id }
    }

    @discardableResult
    func addCard() -> Card {
        let card = Card(backgroundColor: .random())
        cards.append(card)
        card.save()
        return card
    }

    func remove(_ card: Card) {
        guard let index = index(for: card) else { return }
        for element in cards[index].elements {
            if let image = element as? ImageElement, let filename = image.imageFilename {
                try? FileManager.default.removeItem(at: URL.documentsDirectory.appendingPathComponent(filename))
            }
        }
        let id = cards[index].id
        try? FileManager.default.removeItem(at: URL.documentsDirectory.appendingPathComponent("\(id).rwcard"))
        cards.remove(at: index)
    }

    func saveAll() {
        cards.forEach { $0.save() }
    }

    private func load() -> [Card] {
        var result: [Card] = []
        let path = URL.documentsDirectory.path
        guard let enumerator = FileManager.default.enumerator(atPath: path),
              let files = enumerator.allObjects as? [String] else { return result }
        for file in files where file.hasSuffix(".rwcard") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path).appendingPathComponent(file))
                result.append(try JSONDecoder().decode(Card.self, from: data))
            } catch {
                print("Card load error:", error.localizedDescription)
            }
        }
        return result
    }
}
