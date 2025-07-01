//
//  GlassmorphicBackground.swift
//  Iodda
//
//  Created by Vlad on 1/7/25.
//

import SwiftUI

struct GlassmorphicBackground: View {
    let gradientColors: [Color]
    let cornerRadius: CGFloat
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.thinMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(
                        LinearGradient(
                            colors: gradientColors.map {
                                $0.opacity(colorScheme == .dark ? 0.3 : 0.2)
                            },
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(colorScheme == .dark ? 0.25 : 0.35),
                                Color.white.opacity(colorScheme == .dark ? 0.08 : 0.12),
                                Color.clear
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(
                color: gradientColors.first?.opacity(colorScheme == .dark ? 0.25 : 0.15) ?? Color.blue.opacity(0.15),
                radius: 15, x: 0, y: 8
            )
            .shadow(
                color: .black.opacity(colorScheme == .dark ? 0.15 : 0.06),
                radius: 4, x: 0, y: 2
            )
    }
}

#Preview {
    GlassmorphicBackground(gradientColors: [Color.blue, Color.pink], cornerRadius: 24)
}
