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
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack {
            // Glassmorphism background with theme adaptation
            GlassmorphicBackground(
                gradientColors: budget.gradientColors,
                cornerRadius: 24
            )
            
            VStack(spacing: 24) {
                // Top section with emoji and main amounts
                HStack(alignment: .center, spacing: 20) {
                    // Animated emoji with glow effect
                    EmojiIconView(
                        emoji: budget.emoji,
                        gradientColors: budget.gradientColors,
                        size: 80
                    )
                    
                    Spacer()
                    
                    // Main financial info
                    VStack(alignment: .trailing, spacing: 8) {
                        // Total amount
                        VStack(alignment: .trailing, spacing: 2) {
                            Text("Total Budget")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                            
                            Text(budget.totalAmount, format: .currency(code: "USD"))
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                        }
                        
                        // Remaining amount with color coding
                        VStack(alignment: .trailing, spacing: 2) {
                            Text("Remaining")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                            
                            Text(budget.remainingAmount, format: .currency(code: "USD"))
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(remainingAmountColor)
                        }
                    }
                }
                
                // Financial stats row
                HStack(spacing: 20) {
                    // Spent amount
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 4) {
                            Image(systemName: "minus.circle.fill")
                                .font(.caption)
                                .foregroundStyle(.red)
                            
                            Text("Spent")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                        }
                        
                        Text(budget.spentAmount, format: .currency(code: "USD"))
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                    }
                    
                    Spacer()
                    
                    // Creation date
                    VStack(alignment: .trailing, spacing: 4) {
                        HStack(spacing: 4) {
                            Text("Created")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                            
                            Image(systemName: "calendar")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Text(budget.creationDate, style: .date)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary)
                    }
                }
                
                // Progress indicator
                ProgressIndicatorView(budget: budget, animateProgress: animateProgress)
                
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 20)
        }
        .frame(maxWidth: .infinity)
    }
    
    // Helper computed property for remaining amount color
    private var remainingAmountColor: Color {
        let percentage = budget.remainingAmount / budget.totalAmount
        
        if percentage > 0.5 {
            return .green
        } else if percentage > 0.2 {
            return .orange
        } else {
            return .red
        }
    }
}

#Preview {
    @Previewable @State var animateProgress = true
    
    Group {
        // Light theme preview
        ExpensesListHeaderView(
            budget: Budget(
                budgetName: "Sample Budget",
                totalAmount: 1000.0,
                spentAmount: 350.0,
                remainingAmount: 650.0,
                creationDate: Date(),
                emoji: "💰",
                gradientColors: [Color.blue, Color.purple],
                expenses: [],
            ),
            animateProgress: $animateProgress
        )
        .preferredColorScheme(.light)
        
        // Dark theme preview
        ExpensesListHeaderView(
            budget: Budget(
                budgetName: "Sample Budget",
                totalAmount: 1000.0,
                spentAmount: 850.0,
                remainingAmount: 150.0,
                creationDate: Date(),
                emoji: "🛒",
                gradientColors: [Color.orange, Color.red],
                expenses: []
            ),
            animateProgress: $animateProgress
        )
        .preferredColorScheme(.dark)
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
