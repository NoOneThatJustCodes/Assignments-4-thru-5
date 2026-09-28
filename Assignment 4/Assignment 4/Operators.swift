//
//  Operators.swift
//  Assignment 4
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

func + (left: CGSize, right: CGSize) -> CGSize {
    CGSize(width: left.width + right.width, height: left.height + right.height)
}
