//
//  PrevoewData.swift
//  Assignment 4
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

let initialCards: [Card] = {
    var first = Card(backgroundColor: .yellow)
    first.elements = [
        ImageElement(uiImage: UIImage(systemName: "sun.max.fill")),
        TextElement(text: "Hello!", textColor: .black),
        ImageElement(uiImage: UIImage(systemName: "heart.fill"))
    ]

    var second = Card(backgroundColor: .mint)
    second.elements = [TextElement(text: "Have a great day!", textColor: .black)]

    var third = Card(backgroundColor: .pink)
    third.elements = [ImageElement(uiImage: UIImage(systemName: "star.fill"))]

    var fourth = Card(backgroundColor: .orange)
    fourth.elements = [TextElement(text: "You got this!", textColor: .black)]

    var fifth = Card(backgroundColor: .cyan)
    fifth.elements = [ImageElement(uiImage: UIImage(systemName: "gift.fill"))]

    return [first, second, third, fourth, fifth]
}()
