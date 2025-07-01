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
        ZStack {
            // Glassmorphism background with theme adaptation
            GlassmorphicBackground(
                gradientColors: budget.gradientColors,
                cornerRadius: 24
            )
            
            // Floating emoji with enhanced styling
            VStack {
                HStack {
                    Spacer()
                    EmojiIconView.large(
                        emoji: budget.emoji,
                        gradientColors: budget.gradientColors,
                        animate: false
                    )
                    .padding(.top, 12)
                    .padding(.trailing, 20)
                }
                Spacer()
            }
            
            // Main content
            VStack(spacing: 18) {
                // Header section
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(budget.budgetName)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                            .lineLimit(1)
                            .padding(.trailing, 80)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "calendar")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Text(dateFormatter.string(from: budget.creationDate))
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                        }
                    }
                    Spacer()
                }
                
                // Progress section
                VStack(spacing: 10) {
                    // Enhanced progress bar
                    ProgressIndicatorView(budget: budget, animateProgress: true)
                    
                    // Enhanced amount info cards
                    HStack(spacing: 8) {
                        AmountCard(
                            title: LocalizedStringKey("total_amount"),
                            amount: budget.totalAmount,
                            icon: "creditcard.fill",
                            color: .blue,
                            colorScheme: colorScheme
                        )
                        
                        AmountCard(
                            title: LocalizedStringKey("spent"),
                            amount: budget.spentAmount,
                            icon: isOverBudget ? "exclamationmark.triangle.fill" : "minus.circle.fill",
                            color: isOverBudget ? .red : .orange,
                            colorScheme: colorScheme
                        )
                        
                        AmountCard(
                            title: LocalizedStringKey("remaining"),
                            amount: budget.remainingAmount,
                            icon: budget.remainingAmount > 0 ? "plus.circle.fill" : "checkmark.circle.fill",
                            color: remainingAmountColor,
                            colorScheme: colorScheme
                        )
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
        }
        .frame(height: 160)
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
    
    // MARK: - Methods
    private func formattedCurrency(amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = amount.truncatingRemainder(dividingBy: 1) == 0 ? 0 : 2
        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount) €"
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 20) {
        // Light theme
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
        .preferredColorScheme(.light)
        
        // Dark theme - over budget example
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
        .preferredColorScheme(.dark)
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
