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
    
    private var progressPercentage: Double {
        guard budget.totalAmount > 0 else { return 0 }
        return min(budget.spentAmount / budget.totalAmount, 1.0)
    }
    
    private var isOverBudget: Bool {
        budget.spentAmount > budget.totalAmount
    }

    private var progressBarColor: Color {
        if isOverBudget {
            return .red
        } else if progressPercentage < 0.8 {
            return .green
        } else {
            return .orange
        }
    }
    
    var body: some View {
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
        }
    }
}
