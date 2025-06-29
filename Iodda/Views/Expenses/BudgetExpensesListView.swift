//
//  BudgetExpensesListView.swift
//  Iodda
//
//  Created by Vlad on 29/6/25.
//

import SwiftUI

struct BudgetExpensesListView: View {
    // MARK: - Properties
    let budget: Budget
    @State private var animateProgress = false
    @State private var showEmptyState = false
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Dynamic gradient background
                BackgroundGradientView(budget: budget)
                    .ignoresSafeArea()
                    .zIndex(0)
                
                // Background particles effect
                ParticlesView()
                    .ignoresSafeArea()
                    .opacity(0.4)
                    .zIndex(1)
                
                // Main content
                VStack(spacing: 0) {
                    // Premium budget header
                    ExpensesListHeaderView(budget: budget, animateProgress: $animateProgress)
                        .padding(.horizontal, 20)
                        .padding(.top, geometry.safeAreaInsets.top > 0 ? 0 : 20)
                    
                    // Section title with spacing
                    HStack {
                        Text("Expenses")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                        
                        
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 32)
                    .padding(.bottom, 16)
                    
                    // Content area
                    if budget.expenses.isEmpty {
                        ExpenseEmptyStateView()
                            .opacity(showEmptyState ? 1 : 0)
                            .scaleEffect(showEmptyState ? 1 : 0.8)
                            .animation(.spring(response: 0.8, dampingFraction: 0.8).delay(0.3), value: showEmptyState)
                    } else {
                        ExpensesListView(budget: budget)
                    }
                    
                    Spacer()
                }
                .zIndex(2)
            }
        }
        .navigationTitle(budget.budgetName)
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.2)) {
                animateProgress = true
            }
            withAnimation(.easeInOut(duration: 0.6).delay(0.5)) {
                showEmptyState = true
            }
        }
    }
}

// MARK: - Background Gradient View
struct BackgroundGradientView: View {
    let budget: Budget
    
    var body: some View {
        LinearGradient(
            colors: [
                budget.gradientColors.first?.opacity(0.12) ?? Color.blue.opacity(0.12),
                Color.clear,
                budget.gradientColors.last?.opacity(0.08) ?? Color.purple.opacity(0.08)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - Budget Header View


// MARK: - Emoji Icon View
struct EmojiIconView: View {
    let emoji: String
    let gradientColors: [Color]
    let animate: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: gradientColors.map { $0.opacity(0.15) },
                        center: .center,
                        startRadius: 5,
                        endRadius: 22
                    )
                )
                .frame(width: 44, height: 44)
            
            Text(emoji)
                .font(.system(size: 24))
                .scaleEffect(animate ? 1.05 : 1.0)
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animate)
        }
    }
}

// MARK: - Amount Display View
struct AmountDisplayView: View {
    let budget: Budget
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 4) {
            HStack(spacing: 2) {
                Text("€")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                
                Text(String(format: "%.0f", budget.spentAmount))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .contentTransition(.numericText())
            }
            
            Text("из €\(String(format: "%.0f", budget.totalAmount))")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Progress Indicator View
struct ProgressIndicatorView: View {
    let budget: Budget
    let animateProgress: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Progress")
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

// MARK: - Expenses List View
struct ExpensesListView: View {
    let budget: Budget
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(Array(budget.expenses.enumerated()), id: \.element.id) { index, expense in
                    ExpenseCellView(expense: expense, budget: budget)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(Double(index) * 0.05), value: budget.expenses)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 100) // Safe area for bottom
        }
    }
}

// MARK: - Particles View for Background Effect
struct ParticlesView: View {
    @State private var animate = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<12, id: \.self) { i in
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color.blue.opacity(0.08), Color.clear],
                                center: .center,
                                startRadius: 1,
                                endRadius: 8
                            )
                        )
                        .frame(width: CGFloat.random(in: 3...8))
                        .position(
                            x: animate ? CGFloat.random(in: 0...geometry.size.width) : CGFloat.random(in: 0...geometry.size.width),
                            y: animate ? CGFloat.random(in: 0...geometry.size.height) : CGFloat.random(in: 0...geometry.size.height)
                        )
                        .animation(
                            .linear(duration: Double.random(in: 8...15))
                            .repeatForever(autoreverses: true)
                            .delay(Double.random(in: 0...3)),
                            value: animate
                        )
                }
            }
            .onAppear {
                animate = true
            }
        }
    }
}

// MARK: - Custom Button Style
struct PressedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        BudgetExpensesListView(budget: Budget(
            budgetName: "Trip in Paris",
            totalAmount: 1500.0,
            spentAmount: 850.0,
            remainingAmount: 650.0,
            creationDate: Date(),
            emoji: "🇫🇷",
            gradientColors: [Color.blue.opacity(0.6), Color.purple.opacity(0.4)],
            expenses: []
        ))
    }
}
