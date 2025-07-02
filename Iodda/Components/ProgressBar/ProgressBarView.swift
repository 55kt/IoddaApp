//
//  ProgressBarView.swift
//  Iodda
//
//  Created by Vlad on 2/7/25.
//

import SwiftUI

enum ProgressBarStyle {
    case budgetCell
    case expenseHeader
}

struct ProgressBarView: View {
    let budget: Budget
    let style: ProgressBarStyle
    @State private var animateProgress = false
    
    var body: some View {
        let progressPercentage = progressPercentage(spentAmount: budget.spentAmount, totalAmount: budget.totalAmount)
        let isOverBudget = isOverBudget(spentAmount: budget.spentAmount, totalAmount: budget.totalAmount)
        let progressBarColor = isOverBudget ? Color.red : (progressPercentage < 0.8 ? .green : .orange)

        switch style {
        case .budgetCell:
            VStack(spacing: 8) {
                HStack {
                    Text("Progress")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(formattedCurrency(amount: budget.spentAmount))
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(isOverBudget ? .red : .primary)
                    Text("of")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(formattedCurrency(amount: budget.totalAmount))
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                }
                
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color(.systemGray5))
                        .frame(height: 8)
                        .overlay(
                            HStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(progressBarColor)
                                    .frame(
                                        width: min(geometry.size.width * progressPercentage, geometry.size.width),
                                        height: 8
                                    )
                                Spacer(minLength: 0)
                            }
                        )
                }
                .frame(height: 8)
            }
            
        case .expenseHeader:
            VStack(spacing: 12) {
                HStack {
                    Text("Progress")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                    
                    Spacer()
                    
                    Text("\(Int(progressPercentage * 100))%")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(progressPercentage > 1.0 ? .red : .secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            Capsule()
                                .fill(Color(.systemGray6).opacity(0.5))
                        )
                }
                
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemGray5))
                        .frame(height: 12)
                        .overlay(
                            HStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(progressBarColor)
                                    .frame(
                                        width: min(geometry.size.width * progressPercentage, geometry.size.width),
                                        height: 12
                                    )
                                    .animation(.easeInOut(duration: animateProgress ? 1.0 : 0), value: progressPercentage)
                                Spacer(minLength: 0)
                            }
                        )
                }
                .frame(height: 12)
                
                HStack {
                    Text(budget.spentAmount, format: .currency(code: "USD"))
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.primary)
                    
                    Text("of")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text(budget.totalAmount, format: .currency(code: "USD"))
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.primary)
                    
                    Spacer()
                    
                    if isOverBudget {
                        HStack(spacing: 4) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.caption2)
                                .foregroundStyle(.red)
                            Text("Over Budget")
                                .font(.caption2)
                                .fontWeight(.medium)
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.2)) {
                    animateProgress = true
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ProgressBarView(
            budget: Budget(
                budgetName: "Trip Budget",
                totalAmount: 1000.0,
                spentAmount: 500.0,
                remainingAmount: 500.0,
                creationDate: Date(),
                emoji: "✈️",
                gradientColors: [Color.blue, Color.purple],
                expenses: []
            ),
            style: .budgetCell
        )

        ProgressBarView(
            budget: Budget(
                budgetName: "Over Budget",
                totalAmount: 1000.0,
                spentAmount: 1200.0,
                remainingAmount: -200.0,
                creationDate: Date(),
                emoji: "🚨",
                gradientColors: [Color.red, Color.orange],
                expenses: []
            ),
            style: .expenseHeader
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
