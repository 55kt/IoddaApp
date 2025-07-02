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
        VStack(spacing: 20) {
            // Main info section
            HStack(alignment: .center, spacing: 20) {
                // Clean emoji display
                Text(budget.emoji)
                    .font(.system(size: 54))
                    .frame(width: 80, height: 80)
                    .background(
                        Circle()
                            .fill(.ultraThinMaterial)
                            .stroke(
                                Color(.systemGray4).opacity(colorScheme == .dark ? 0.3 : 0.6),
                                lineWidth: 0.5
                            )
                    )
                
                Spacer()
                
                // Financial summary
                VStack(alignment: .trailing, spacing: 12) {
                    // Total budget
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Total Budget")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        Text(budget.totalAmount, format: .currency(code: "USD"))
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                    }
                    
                    // Remaining amount
                    VStack(alignment: .trailing, spacing: 4) {
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
            
            // Stats section
            HStack(spacing: 0) {
                // Spent amount
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 4) {
                        Image(systemName: "minus.circle.fill")
                            .font(.caption)
                            .foregroundStyle(budget.spentAmount > budget.totalAmount ? .red : .orange)
                        
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
                VStack(alignment: .trailing, spacing: 6) {
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
            
            // Progress section
            ProgressBarView(budget: budget, style: .expenseHeader)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .stroke(
                    Color(.systemGray4).opacity(colorScheme == .dark ? 0.3 : 0.6),
                    lineWidth: 0.5
                )
        )
    }
    
    // MARK: - Computed Properties
    private var remainingAmountColor: Color {
        if budget.remainingAmount <= 0 {
            return .red
        }
        
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
    
    VStack(spacing: 20) {
        // Normal budget
        ExpensesListHeaderView(
            budget: Budget(
                budgetName: "Trip in Paris",
                totalAmount: 1000.0,
                spentAmount: 350.0,
                remainingAmount: 650.0,
                creationDate: Date(),
                emoji: "🇫🇷",
                gradientColors: [Color.blue, Color.purple],
                expenses: []
            ),
            animateProgress: $animateProgress
        )
        
        // Over budget
        ExpensesListHeaderView(
            budget: Budget(
                budgetName: "Entertainment",
                totalAmount: 500.0,
                spentAmount: 650.0,
                remainingAmount: -150.0,
                creationDate: Date(),
                emoji: "🎬",
                gradientColors: [Color.orange, Color.red],
                expenses: []
            ),
            animateProgress: $animateProgress
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
