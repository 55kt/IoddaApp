//
//  ProgressIndicatorView.swift
//  Iodda
//
//  Created by Vlad on 30/6/25.
//

import SwiftUI

struct ProgressIndicatorView: View {
    let budget: Budget
    let animateProgress: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("progress_bar_line_title")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Text("\(Int(budget.progressPercentage * 100))%")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(budget.isOverBudget ? .red : .primary)
                    .contentTransition(.numericText())
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background track
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.black.opacity(0.08))
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.ultraThinMaterial)
                        )
                        .frame(height: 8)
                    
                    // Progress fill with animation
                    RoundedRectangle(cornerRadius: 6)
                        .fill(
                            LinearGradient(
                                colors: budget.isOverBudget ?
                                [.red, .orange] :
                                [budget.gradientColors.first ?? .green,
                                 budget.gradientColors.last ?? .teal],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(
                            width: animateProgress ?
                            max(8, min(geometry.size.width, CGFloat(budget.progressPercentage) * geometry.size.width)) : 8,
                            height: 8
                        )
                        .shadow(color: (budget.gradientColors.first ?? .green).opacity(0.4), radius: 3, x: 0, y: 1)
                        .animation(.easeInOut(duration: 1.5), value: animateProgress)
                }
            }
            .frame(height: 8)
        }
    }
}

#Preview {
    Group {
        ProgressIndicatorView(
            budget: Budget( budgetName: "0%", totalAmount: 1000.0, spentAmount: 0.0, remainingAmount: 1000.0, creationDate: Date(), emoji: "💰", gradientColors: [Color.blue, Color.purple], expenses: []),
            animateProgress: true
        )
        ProgressIndicatorView(
            budget: Budget( budgetName: "Over Budget", totalAmount: 1000.0, spentAmount: 1200.0, remainingAmount: -200.0, creationDate: Date(), emoji: "💰", gradientColors: [Color.blue, Color.purple], expenses: []),
            animateProgress: true
        )
    }
    .padding(.horizontal)
}
