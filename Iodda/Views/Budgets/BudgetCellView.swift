//
//  BudgetCellView.swift
//  Iodda
//
//  Created by Vlad on 27/6/25.
//

import SwiftUI

struct BudgetCellView: View {
    // MARK: - Properties
    var budgetName: String = "Unnamed Budget"
    var totalAmount: Double = 0.0
    var spentAmount: Double = 0.0
    var remainingAmount: Double = 0.0
    var creationDate: Date = Date()
    var emoji: String = "💰"
    var gradientColors: [Color] = [Color.gray.opacity(0.3), Color.gray.opacity(0.1)]
    
    let currentLanguage: String
    
    // MARK: - Computed Properties
    private var progressPercentage: Double {
        guard totalAmount > 0 else { return 0 }
        return min(spentAmount / totalAmount, 1.0)
    }
    
    private var isOverBudget: Bool {
        spentAmount > totalAmount
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // Background with glassmorphism effect
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: gradientColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )// fill
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                colors: [Color.white.opacity(0.2), Color.clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                        )// stroke
                )// overlay
            
            // Floating emoji with backdrop blur
            VStack {
                HStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 60, height: 60)
                        
                        Text(emoji)
                            .font(.system(size: 32))
                    }// ZStack
                    .padding(.top, 4)
                    .padding(.trailing, 16)
                }// HStack
                Spacer()
            }// VStack
            
            // Main content
            VStack(spacing: 16) {
                // Header section
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(budgetName)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                            .lineLimit(1)
                            .padding(.trailing, 60)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "calendar.badge.clock")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Text(dateFormatter.string(from: creationDate))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }// HStack
                    }// VStack
                    Spacer()
                }// HStack
                
                // Progress section
                VStack(spacing: 12) {
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
                            amount: totalAmount,
                            icon: "creditcard.fill",
                            color: .blue
                        )
                        
                        AmountCard(
                            title: LocalizedStringKey("spent"),
                            amount: spentAmount,
                            icon: isOverBudget ? "exclamationmark.triangle.fill" : "minus.circle.fill",
                            color: isOverBudget ? .red : .orange
                        )
                        
                        AmountCard(
                            title: LocalizedStringKey("remaining"),
                            amount: remainingAmount,
                            icon: remainingAmount > 0 ? "plus.circle.fill" : "checkmark.circle.fill",
                            color: remainingAmount > 0 ? .green : .gray
                        )
                    }// HStack
                }// VStack
            }// VStack
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }// ZStack
        .frame(height: 140)
        .padding(.horizontal, -16)
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
#Preview {
    ScrollView {
        VStack(spacing: 20) {
            BudgetCellView(
                budgetName: "Trip to Paris and other countries and hitler caput",
                totalAmount: 500.00,
                spentAmount: 350.00,
                remainingAmount: 150.00,
                creationDate: Date(),
                emoji: "🇫🇷",
                gradientColors: [
                    Color.blue.opacity(0.6),
                    Color.purple.opacity(0.4)
                ],
                currentLanguage: "en"
            )
            
            BudgetCellView(
                budgetName: "Shopping Spree",
                totalAmount: 200.00,
                spentAmount: 250.00,
                remainingAmount: -50.00,
                creationDate: Date().addingTimeInterval(-86400),
                emoji: "🛒",
                gradientColors: [
                    Color.red.opacity(0.6),
                    Color.orange.opacity(0.4)
                ],
                currentLanguage: "en"
            )
            
            BudgetCellView(
                budgetName: "Gym Membership",
                totalAmount: 100.00,
                spentAmount: 100.00,
                remainingAmount: 0.00,
                creationDate: Date().addingTimeInterval(-172800),
                emoji: "💪",
                gradientColors: [
                    Color.green.opacity(0.6),
                    Color.teal.opacity(0.4)
                ],
                currentLanguage: "en"
            )
            
            BudgetCellView(
                budgetName: "Very Long Budget Name That Should Test Text Wrapping",
                totalAmount: 1500.00,
                spentAmount: 750.00,
                remainingAmount: 750.00,
                creationDate: Date(),
                emoji: "💸",
                gradientColors: [
                    Color.yellow.opacity(0.6),
                    Color.orange.opacity(0.4)
                ],
                currentLanguage: "en"
            )
            
            BudgetCellView(currentLanguage: "en")
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}
