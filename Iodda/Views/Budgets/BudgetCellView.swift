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
            // Background with glassmorphism effect
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    LinearGradient(
                        colors: budget.gradientColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )// fill
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(
                            LinearGradient(
                                colors: [Color.white.opacity(0.2), Color.clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                        )// stroke
                )// overlay
                .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
            
            // Floating emoji with backdrop blur
            VStack {
                HStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 70, height: 70)
                        
                        Text(budget.emoji)
                            .font(.system(size: 40))
                    }// ZStack
                    .padding(.top, 8)
                    .padding(.trailing, 20)
                }// HStack
                Spacer()
            }// VStack
            
            // Main content
            VStack(spacing: 20) {
                // Header section
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(budget.budgetName)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                            .lineLimit(1)
                            .padding(.trailing, 60)
                        
                        HStack(spacing: 6) {
                            Image(systemName: "calendar.badge.clock")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Text(dateFormatter.string(from: budget.creationDate))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }// HStack
                    }// VStack
                    Spacer()
                }// HStack
                
                // Progress section
                VStack(spacing: 16) {
                    // Progress bar
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.black.opacity(0.1))
                            .frame(height: 6)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(
                                LinearGradient(
                                    colors: isOverBudget
                                        ? [.red, .orange]
                                        : [.green, .teal],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )// fill
                            .frame(width: max(0, CGFloat(progressPercentage) * 280), height: 6)
                            .animation(.spring(response: 0.8, dampingFraction: 0.8), value: progressPercentage)
                    }// ZStack
                    .frame(maxWidth: .infinity)
                    
                    // Amount info cards
                    HStack(spacing: 6) {
                        AmountCard(
                            title: LocalizedStringKey("total_amount"),
                            amount: budget.totalAmount,
                            icon: "creditcard.fill",
                            color: .blue
                        )
                        
                        AmountCard(
                            title: LocalizedStringKey("spent"),
                            amount: budget.spentAmount,
                            icon: isOverBudget ? "exclamationmark.triangle.fill" : "minus.circle.fill",
                            color: isOverBudget ? .red : .orange
                        )
                        
                        AmountCard(
                            title: LocalizedStringKey("remaining"),
                            amount: budget.remainingAmount,
                            icon: budget.remainingAmount > 0 ? "plus.circle.fill" : "checkmark.circle.fill",
                            color: budget.remainingAmount > 0 ? .green : .gray
                        )
                    }// HStack
                }// VStack
            }// VStack
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }// ZStack
        .frame(height: 160)
    }// body
    
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
}// View

// MARK: - AmountCard SubView с горизонтальным расширением
struct AmountCard: View {
    let title: LocalizedStringKey
    let amount: Double
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.caption2)
                    .foregroundStyle(color)
                
                Text(title)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }// HStack
            
            Text(formattedCurrency(amount: amount))
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }// VStack
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(color.opacity(0.3), lineWidth: 0.5)
        )// overlay
    }// body
    
    private func formattedCurrency(amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = amount.truncatingRemainder(dividingBy: 1) == 0 ? 0 : 2
        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount) €"
    }
}// View

// MARK: - Preview

