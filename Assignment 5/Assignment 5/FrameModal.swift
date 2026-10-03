//
//  FrameModal.swift
//  Assignment 5
//
//  Created by Jonathan S. on 10/1/26.
//

import SwiftUI

struct FrameModal: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var frameIndex: Int?
    private let columns = [GridItem(.adaptive(minimum: 120), spacing: 10)]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(0..<Shapes.shapes.count, id: \.self) { index in
                        Shapes.shapes[index]
                            .fill(Color.secondary)
                            .overlay(Shapes.shapes[index].stroke(Color.primary, lineWidth: 4))
                            .frame(width: 100, height: 120)
                            .padding()
                            .onTapGesture {
                                frameIndex = index
                                dismiss()
                            }
                    }
                }
                .padding(5)
            }
            .navigationTitle("Frames")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
