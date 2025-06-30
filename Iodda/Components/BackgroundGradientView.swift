//
//  BackgroundGradientView.swift
//  Iodda
//
//  Created by Vlad on 30/6/25.
//

import SwiftUI

struct BackgroundGradientView: View {
    let budget: Budget
    
    var body: some View {
        LinearGradient(
            colors: [
                budget.gradientColors.first?.opacity(0.12) ?? Color.blue.opacity(0.12),
                Color.clear,
                budget.gradientColors.last?.opacity(0.08) ?? Color.purple.opacity(0.08)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

#Preview {
     Group {
        ZStack {
            BackgroundGradientView(
                budget: Budget(
                    budgetName: "Blue-Purple",
                    totalAmount: 1000.0,
                    spentAmount: 500.0,
                    remainingAmount: 500.0,
                    creationDate: Date(),
                    emoji: "💰",
                    gradientColors: [Color.blue, Color.purple],
                    expenses: []
                )
            )
            Rectangle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                .overlay(
                    Text("Blue-Purple Gradient")
                        .foregroundStyle(.white)
                        .font(.caption)
                )
        }
        .frame(width: 300, height: 200)
        
        ZStack {
            BackgroundGradientView(
                budget: Budget(
                    budgetName: "Green-Teal",
                    totalAmount: 1000.0,
                    spentAmount: 0.0,
                    remainingAmount: 1000.0,
                    creationDate: Date(),
                    emoji: "🌱",
                    gradientColors: [Color.green, Color.teal],
                    expenses: []
                )
            )
            Rectangle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                .overlay(
                    Text("Green-Teal Gradient")
                        .foregroundStyle(.white)
                        .font(.caption)
                )
        }
        .frame(width: 300, height: 200)
        
        ZStack {
            BackgroundGradientView(
                budget: Budget(
                    budgetName: "Red-Orange",
                    totalAmount: 1000.0,
                    spentAmount: 1200.0,
                    remainingAmount: -200.0,
                    creationDate: Date(),
                    emoji: "🚨",
                    gradientColors: [Color.red, Color.orange],
                    expenses: []
                )
            )
            Rectangle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                .overlay(
                    Text("Red-Orange Gradient")
                        .foregroundStyle(.white)
                        .font(.caption)
                )
        }
        .frame(width: 300, height: 200)
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
