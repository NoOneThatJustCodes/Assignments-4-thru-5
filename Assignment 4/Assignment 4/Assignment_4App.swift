//
//  Assignment_4App.swift
//  Assignment 4
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

@main
struct Assignment_4App: App {
    @StateObject private var store = CardStore(defaultData: true)

    var body: some Scene {
        WindowGroup {
            CardsListView()
                .environmentObject(store)
        }
    }
}
