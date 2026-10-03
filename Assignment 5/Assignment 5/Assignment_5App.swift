//
//  Assignment_5App.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

@main
struct Assignment_5App: App {
    @StateObject private var store = CardStore(defaultData: false)

    var body: some Scene {
        WindowGroup {
            CardsListView()
                .environmentObject(store)
        }
    }
}
