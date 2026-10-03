//
//  ToolbarSelection.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/24/26.
//

import Foundation

enum ToolbarSelection: CaseIterable, Identifiable {
    case photoModal, frameModal, stickerModal, textModal
    var id: Self { self }
}
