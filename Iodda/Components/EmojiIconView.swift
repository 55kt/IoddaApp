//
//  EmojiIconView.swift
//  Iodda
//
//  Created by Vlad on 30/6/25.
//

import SwiftUI

struct EmojiIconView: View {
    let emoji: String
    let gradientColors: [Color]
    let size: CGFloat
    
    @Environment(\.colorScheme) private var colorScheme
    
    // Convenience computed properties for different sizes
    private var circleSize: CGFloat { size * 1.8 }
    private var emojiSize: CGFloat { size }
    private var backgroundOpacity: Double { colorScheme == .dark ? 0.25 : 0.15 }
    private var glowOpacity: Double { colorScheme == .dark ? 0.4 : 0.2 }
    
    var body: some View {
        ZStack {
            // Background circle with theme-adaptive gradient
            Circle()
                .fill(
                    RadialGradient(
                        colors: gradientColors.map { $0.opacity(backgroundOpacity) },
                        center: .center,
                        startRadius: circleSize * 0.1,
                        endRadius: circleSize * 0.5
                    )
                )
                .frame(width: circleSize, height: circleSize)
                .overlay(
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(colorScheme == .dark ? 0.15 : 0.25),
                                    Color.clear
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .shadow(
                    color: gradientColors.first?.opacity(glowOpacity) ?? Color.blue.opacity(glowOpacity),
                    radius: circleSize * 0.15,
                    x: 0,
                    y: circleSize * 0.05
                )
            
            // Emoji with adaptive styling
            Text(emoji)
                .font(.system(size: emojiSize))
                .shadow(
                    color: .black.opacity(colorScheme == .dark ? 0.3 : 0.1),
                    radius: 2,
                    x: 0,
                    y: 1
                )
        }
    }
}

// MARK: - Size Presets
extension EmojiIconView {
    // Convenience initializers for common sizes
    static func small(emoji: String, gradientColors: [Color], animate: Bool = false) -> EmojiIconView {
        EmojiIconView(emoji: emoji, gradientColors: gradientColors, size: 16)
    }
    
    static func medium(emoji: String, gradientColors: [Color], animate: Bool = false) -> EmojiIconView {
        EmojiIconView(emoji: emoji, gradientColors: gradientColors, size: 24)
    }
    
    static func large(emoji: String, gradientColors: [Color], animate: Bool = false) -> EmojiIconView {
        EmojiIconView(emoji: emoji, gradientColors: gradientColors, size: 32)
    }
    
    static func extraLarge(emoji: String, gradientColors: [Color], animate: Bool = false) -> EmojiIconView {
        EmojiIconView(emoji: emoji, gradientColors: gradientColors, size: 40)
    }
}

#Preview {
    VStack(spacing: 30) {
        // Size comparison - Light theme
        HStack(spacing: 20) {
            VStack(spacing: 8) {
                EmojiIconView.small(emoji: "💰", gradientColors: [Color.blue, Color.purple])
                Text("Small (16pt)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            
            VStack(spacing: 8) {
                EmojiIconView.medium(emoji: "💰", gradientColors: [Color.blue, Color.purple])
                Text("Medium (24pt)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            
            VStack(spacing: 8) {
                EmojiIconView.large(emoji: "💰", gradientColors: [Color.blue, Color.purple])
                Text("Large (32pt)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            
            VStack(spacing: 8) {
                EmojiIconView.extraLarge(emoji: "💰", gradientColors: [Color.blue, Color.purple], animate: true)
                Text("Extra Large (40pt)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        
        Divider()
        
        // Different emojis with animation
        HStack(spacing: 20) {
            EmojiIconView.large(
                emoji: "🌱",
                gradientColors: [Color.green, Color.teal],
                animate: true
            )
            
            EmojiIconView.large(
                emoji: "🚨",
                gradientColors: [Color.red, Color.orange],
                animate: true
            )
            
            EmojiIconView.large(
                emoji: "🎯",
                gradientColors: [Color.purple, Color.pink],
                animate: false
            )
        }
        
        // Custom size example
        VStack(spacing: 8) {
            EmojiIconView(
                emoji: "🏆",
                gradientColors: [Color.yellow, Color.orange],
                size: 48
            )
            Text("Custom (48pt)")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
