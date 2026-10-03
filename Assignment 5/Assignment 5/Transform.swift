//
//  Transform.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

struct Transform: Codable {
    var size = CGSize(width: 750, height: 500)
    var rotation: Angle = .zero
    var offset: CGSize = .zero
}

extension Angle: Codable {
    enum CodingKeys: CodingKey { case degrees }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(degrees, forKey: .degrees)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let degrees = try container.decode(Double.self, forKey: .degrees)
        self.init(degrees: degrees)
    }
}
