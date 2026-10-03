//
//  ResizableView.swift
//  Assignment 5
//
//  Created by Jonathan S. on 9/24/26.
//

import SwiftUI

struct ResizableView: ViewModifier {
    @Binding var transform: Transform
    var viewScale: CGFloat = 1
    @State private var previousOffset: CGSize = .zero
    @State private var previousRotation: Angle = .zero
    @State private var scale: CGFloat = 1

    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                transform.offset = CGSize(
                    width: previousOffset.width + value.translation.width / max(viewScale, 0.01),
                    height: previousOffset.height + value.translation.height / max(viewScale, 0.01)
                )
            }
            .onEnded { _ in previousOffset = transform.offset }
    }

    var rotationGesture: some Gesture {
        RotationGesture()
            .onChanged { rotation in
                transform.rotation += rotation - previousRotation
                previousRotation = rotation
            }
            .onEnded { _ in previousRotation = .zero }
    }

    var scaleGesture: some Gesture {
        MagnificationGesture()
            .onChanged { scale = $0 }
            .onEnded { value in
                transform.size.width *= value
                transform.size.height *= value
                scale = 1
            }
    }

    func body(content: Content) -> some View {
        content
            .frame(width: transform.size.width, height: transform.size.height)
            .scaleEffect(scale)
            .rotationEffect(transform.rotation)
            .offset(transform.offset)
            .gesture(dragGesture.simultaneously(with: rotationGesture).simultaneously(with: scaleGesture))
            .onAppear { previousOffset = transform.offset }
    }
}

extension View {
    func resizableView(transform: Binding<Transform>, viewScale: CGFloat = 1) -> some View {
        modifier(ResizableView(transform: transform, viewScale: viewScale))
    }
}
