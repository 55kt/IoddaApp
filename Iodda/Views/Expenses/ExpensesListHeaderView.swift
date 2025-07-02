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
    
    // MARK: - State
    @State private var isExpanded = false
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                isExpanded.toggle()
            }
            
//             withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0)) {
//                 isExpanded.toggle()
//             }
            
//             withAnimation(.easeInOut(duration: 0.4).delay(0.1)) {
//                 isExpanded.toggle()
//             }
        }) {
            VStack(spacing: 0) {
                // Header view (changes based on expanded state)
                HStack(alignment: .center, spacing: 16) {
                    if !isExpanded {
                        // Compact view - Emoji + Essential info
                        Text(budget.emoji)
                            .font(.system(size: 40))
                            .frame(width: 60, height: 60)
                            .background(
                                Circle()
                                    .fill(.ultraThinMaterial)
                                    .stroke(
                                        Color(.systemGray4).opacity(colorScheme == .dark ? 0.3 : 0.6),
                                        lineWidth: 0.5
                                    )
                            )
                        
                        // Essential info
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("Total Budget")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                                Spacer()
                                
                                Text(budget.totalAmount, format: .currency(code: "USD"))
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)
                            }
                            
                            HStack {
                                Text("Remaining")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                                Spacer()
                                
                                Text(budget.remainingAmount, format: .currency(code: "USD"))
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(remainingAmountColor)
                            }
                        }
                    } else {
                        // Expanded view - Budget title
                        Text(budget.budgetName)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    
                    // Expand indicator с улучшенной анимацией
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .frame(width: 20)
                        .animation(.easeInOut(duration: 0.3), value: isExpanded)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                
                // Expanded content
                if isExpanded {
                    VStack(spacing: 20) {
                        // Divider
                        Divider()
                            .padding(.horizontal, 20)
                        
                        // Full info section with larger emoji
                        HStack(alignment: .center, spacing: 20) {
                            // Large emoji display
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
                            
                            // Full financial summary
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
                        .padding(.horizontal, 20)
                        
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
                        .padding(.horizontal, 20)
                        
                        // Progress section
                        ProgressBarView(budget: budget, style: .expenseHeader)
                            .padding(.horizontal, 20)
                        
                        // Bottom padding
                        Spacer()
                            .frame(height: 8)
                    }
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.95).combined(with: .opacity).combined(with: .move(edge: .top)),
                        removal: .scale(scale: 0.95).combined(with: .opacity).combined(with: .move(edge: .top))
                    ))
                }
            }
        }
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .stroke(
                    Color(.systemGray4).opacity(colorScheme == .dark ? 0.3 : 0.6),
                    lineWidth: 0.5
                )
        )
        .clipped()
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

// MARK: - Alternative Animation Styles
extension ExpensesListHeaderView {
    
    private func quickAnimation() {
        withAnimation(.easeInOut(duration: 0.15)) {
            isExpanded.toggle()
        }
    }
    
    private func smoothSpringAnimation() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            isExpanded.toggle()
        }
    }
    
    private func customAnimation() {
        withAnimation(.timingCurve(0.25, 0.1, 0.25, 1, duration: 0.4)) {
            isExpanded.toggle()
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
