//
//  BudgetCellView.swift
//  Iodda
//
//  Created by Vlad on 27/6/25.
//

import SwiftUI

struct BudgetCellView: View {
    // MARK: - Properties
    let budget: Budget
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - Computed Properties
    private var progressPercentage: Double {
        guard budget.totalAmount > 0 else { return 0 }
        return min(budget.spentAmount / budget.totalAmount, 1.0)
    }
    
    private var isOverBudget: Bool {
        budget.spentAmount > budget.totalAmount
    }
    
    // MARK: - Body
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(.ultraThinMaterial)
            .stroke(
                Color(.systemGray4).opacity(colorScheme == .dark ? 0.3 : 0.6),
                lineWidth: 0.5
            )
            .overlay(
                VStack(spacing: 16) {
                    // Header section
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            HStack(spacing: 20) {
                                // Clean emoji display
                                Text(budget.emoji)
                                    .font(.system(size: 50))
                                    .background(
                                        Circle()
                                            .fill(Color(.systemBackground))
                                            .opacity(colorScheme == .dark ? 0.3 : 0.8)
                                            .frame(width: 70, height: 70)

                                    )
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(budget.budgetName)
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.primary)
                                        .lineLimit(1)
                                    
                                    HStack(spacing: 7) {
                                        Image(systemName: "calendar")
                                            .font(.title2)
                                            .foregroundStyle(.secondary)
                                        
                                        Text(dateFormatter.string(from: budget.creationDate))
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }
                        .padding(.top, 20)
                        
                        Spacer()
                        
                        // Status indicator
                        VStack(alignment: .trailing, spacing: 4) {
                            if isOverBudget {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundStyle(.red)
                                    .font(.title3)
                            } else {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(progressPercentage < 0.8 ? .green : .orange)
                                    .font(.title3)
                            }
                            
                            Text("\(Int(progressPercentage * 100))%")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    // Progress bar
                    ProgressBarView(budget: budget, style: .budgetCell)
                    
                    // Amount cards
                    HStack(spacing: 12) {
                        AmountCard(
                            title: "Total",
                            amount: budget.totalAmount,
                            icon: "creditcard",
                            color: .blue
                        )
                        
                        AmountCard(
                            title: "Spent",
                            amount: budget.spentAmount,
                            icon: isOverBudget ? "exclamationmark.triangle" : "minus.circle",
                            color: isOverBudget ? .red : .orange
                        )
                        
                        AmountCard(
                            title: "Left",
                            amount: budget.remainingAmount,
                            icon: budget.remainingAmount > 0 ? "plus.circle" : "checkmark.circle",
                            color: remainingAmountColor
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
            )
            .frame(height: 200)
    }
    
    // MARK: - Helper Properties
    private var remainingAmountColor: Color {
        if budget.remainingAmount <= 0 {
            return .gray
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

// MARK: - Preview
#Preview {
    VStack(spacing: 20) {
        // Normal budget
        BudgetCellView(
            budget: Budget(
                budgetName: "Groceries Budget",
                totalAmount: 1000.0,
                spentAmount: 350.0,
                remainingAmount: 650.0,
                creationDate: Date(),
                emoji: "🛒",
                gradientColors: [Color.blue, Color.purple],
                expenses: []
            )
        )
        
        // Over budget example
        BudgetCellView(
            budget: Budget(
                budgetName: "Entertainment",
                totalAmount: 500.0,
                spentAmount: 750.0,
                remainingAmount: -250.0,
                creationDate: Date(),
                emoji: "🎬",
                gradientColors: [Color.red, Color.orange],
                expenses: []
            )
        )
        
        // Nearly finished budget
        BudgetCellView(
            budget: Budget(
                budgetName: "Transport",
                totalAmount: 300.0,
                spentAmount: 280.0,
                remainingAmount: 20.0,
                creationDate: Date(),
                emoji: "🚗",
                gradientColors: [Color.green, Color.blue],
                expenses: []
            )
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
