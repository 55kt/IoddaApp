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
    let animate: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: gradientColors.map { $0.opacity(0.15) },
                        center: .center,
                        startRadius: 5,
                        endRadius: 22
                    )
                )
                .frame(width: 44, height: 44)
            
            Text(emoji)
                .font(.system(size: 24))
                .scaleEffect(animate ? 1.05 : 1.0)
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animate)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        EmojiIconView(
            emoji: "💰",
            gradientColors: [Color.blue, Color.purple],
            animate: true
        )
        
        EmojiIconView(
            emoji: "🌱",
            gradientColors: [Color.green, Color.teal],
            animate: false
        )
        
        EmojiIconView(
            emoji: "🚨",
            gradientColors: [Color.red, Color.orange],
            animate: true
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
