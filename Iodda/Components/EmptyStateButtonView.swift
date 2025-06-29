//
//  EmptyStateButtonView.swift
//  Iodda
//
//  Created by Vlad on 29/6/25.
//

import SwiftUI

struct EmptyStateButtonView: View {
    // MARK: - Properties
    @State private var isAnimating = false
    var buttonName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack(spacing: 12) {
                Image(systemName: "plus.circle.fill")
                    .font(.title3)
                
                Text(buttonName)
                    .font(.headline)
                    .fontWeight(.semibold)
            }// HStack
            .foregroundStyle(.white)
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
            .background(
                LinearGradient(
                    colors: [.blue, .purple],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                in: RoundedRectangle(cornerRadius: 16)
            )// background
            .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
        }// Button
        .scaleEffect(isAnimating ? 1.05 : 1.0)
        .animation(
            .easeInOut(duration: 2.5)
            .repeatForever(autoreverses: true),
            value: isAnimating
        )// animation
    }
}

#Preview {
    EmptyStateButtonView(buttonName: "Empty State Button") {}
}
