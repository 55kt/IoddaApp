//
//  ExpenseCellView.swift
//  Iodda
//
//  Created by Vlad on 29/6/25.
//

import SwiftUI

struct ExpenseCellView: View {
    // MARK: - Properties
    let expense: Expense
    let budget: Budget
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // Material background with subtle gradient
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.gray.opacity(0.3),
                                    Color.gray.opacity(0.1)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 6)
            
            VStack(spacing: 16) {
                // Main content row
                HStack(spacing: 16) {
                    // Emoji in circle with accent color
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: budget.gradientColors.map { $0.opacity(0.2) },
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 50, height: 50)
                        
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: budget.gradientColors.map { $0.opacity(0.5) },
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.5
                            )
                            .frame(width: 50, height: 50)
                        
                        Text(expense.emoji)
                            .font(.system(size: 24))
                    }
                    
                    // Expense details
                    VStack(alignment: .leading, spacing: 6) {
                        // Name and location
                        HStack {
                            Text(expense.expenseName) // Замена expense.name
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                            
                            Spacer()
                            
                            // Amount with accent styling
                            Text("€\(String(format: "%.2f", expense.amount))")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: budget.gradientColors, // Дефолтный градиент
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        }
                        
                        // Location with icon
                        HStack(spacing: 4) {
                            Image(systemName: "location.fill")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                            
                            Text(expense.location) // Замена expense.location
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                        }
                    }
                }
                
                // Bottom details row
                HStack {
                    // Date
                    HStack(spacing: 6) {
                        Image(systemName: "calendar")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                        
                        Text(expense.creationDate, style: .date)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
                    
                    Spacer()
                    
                    // Quantity
                    if expense.quantity > 1 {
                        HStack(spacing: 6) {
                            Image(systemName: "number")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                            
                            Text("\(expense.quantity)x")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
                    }
                }
                
                // Notes section
                if let note = expense.note, !note.isEmpty {
                    Divider()
                        .opacity(0.5)
                    
                    HStack {
                        Image(systemName: "note.text")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                        
                        Text(note)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .frame(minHeight: expense.note?.isEmpty ?? true ? 100 : 120)
    }    
}

// MARK: - Preview
#Preview {
    VStack(spacing: 16) {
        ExpenseCellView(
            expense: Expense(
                expenseName: "Sample Expense",
                amount: 49.99,
                creationDate: Date(),
                emoji: "🏋️",
                location: "Sample Location",
                quantity: 1,
                note: "Sample note"
            ),
            budget: Budget(
                budgetName: "Sample Budget",
                totalAmount: 500.0,
                spentAmount: 350.0,
                remainingAmount: 150.0,
                creationDate: Date(),
                emoji: "🇫🇷",
                gradientColors: [Color.blue.opacity(0.6), Color.purple.opacity(0.4)],
                expenses: []
            )
        )
        ExpenseCellView(
            expense: Expense(
                expenseName: "Another Expense",
                amount: 25.50,
                creationDate: Date().addingTimeInterval(-86400),
                emoji: "🥤",
                location: "Another Location",
                quantity: 2,
                note: nil
            ),
            budget: Budget(
                budgetName: "Sample Budget",
                totalAmount: 500.0,
                spentAmount: 350.0,
                remainingAmount: 150.0,
                creationDate: Date(),
                emoji: "🇫🇷",
                gradientColors: [Color.blue.opacity(0.6), Color.purple.opacity(0.4)],
                expenses: []
            )
        )
    }
    .padding(.horizontal, 20)
    .background(Color(.systemGroupedBackground))
}
