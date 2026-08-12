//
//  Skeleton.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 05.08.2026.
//

import SwiftUI

/// Мерцающая заглушка, которая занимает место контента на время загрузки.
struct Skeleton: View {

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var isAnimating = false

    private let duration: TimeInterval
    private let delay: TimeInterval

    init(duration: TimeInterval = 1.5, delay: TimeInterval = 0) {
        self.duration = duration
        self.delay = delay
    }

    var body: some View {
        Rectangle()
            .fill(Color(.lightGrayPrimary))
            .overlay {
                LinearGradient(
                    colors: [
                        .white.opacity(0),
                        .white.opacity(0.45),
                        .white.opacity(0)
                    ],
                    startPoint: isAnimating ? .trailing : .leading,
                    endPoint: isAnimating ? UnitPoint(x: 2, y: 0.5) : .trailing
                )
            }
            .clipped()
            .onAppear(perform: startAnimation)
            .accessibilityHidden(true)
    }

    private func startAnimation() {
        guard !reduceMotion else { return }

        withAnimation(
            .easeInOut(duration: duration)
                .delay(delay)
                .repeatForever(autoreverses: false)
        ) {
            isAnimating = true
        }
    }
}

#Preview {
    Skeleton()
        .frame(width: 200, height: 100)
        .padding()
}
