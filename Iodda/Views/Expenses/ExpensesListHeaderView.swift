//
//  ExpensesListHeaderView.swift
//  Iodda
//
//  Created by Vlad on 29/6/25.
//

import SwiftUI

struct ExpensesListHeaderView: View {
    let budget: Budget
    @Binding var animateProgress: Bool
    
    var body: some View {
        ZStack {
            // Glassmorphism background with enhanced effects
            RoundedRectangle(cornerRadius: 24)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(
                            LinearGradient(
                                colors: budget.gradientColors.map { $0.opacity(0.25) },
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.3),
                                    Color.white.opacity(0.1),
                                    Color.clear
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .shadow(color: budget.gradientColors.first?.opacity(0.2) ?? Color.blue.opacity(0.2),
                        radius: 15, x: 0, y: 8)
                .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
            
            VStack(spacing: 20) {
                // Budget info with enhanced typography
                HStack(alignment: .center, spacing: 16) {
                    // Animated emoji with glow effect
                    EmojiIconView(
                        emoji: budget.emoji,
                        gradientColors: budget.gradientColors,
                        animate: animateProgress
                    )
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(budget.budgetName)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                            .lineLimit(1)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "calendar")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Text("Total amount")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    // Enhanced amount display
                    AmountDisplayView(budget: budget)
                }
                
                // Enhanced progress indicator
                ProgressIndicatorView(budget: budget, animateProgress: animateProgress)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
        }
        .frame(maxHeight: 150)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    @Previewable @State var animateProgress = true
    
 Group {
        ExpensesListHeaderView(
            budget: Budget(
                budgetName: "Sample Budget",
                totalAmount: 1000.0,
                spentAmount: 500.0,
                remainingAmount: 500.0,
                creationDate: Date(),
                emoji: "💰",
                gradientColors: [Color.blue, Color.purple],
                expenses: []
            ),
            animateProgress: $animateProgress
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
