//
//  TextExtensions.swift
//  Assignment 4
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

extension View {
    func scalableText() -> some View {
        minimumScaleFactor(0.01)
            .lineLimit(1)
    }
}
