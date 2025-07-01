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
    @State private var searchText = ""
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                // Dynamic gradient background
                BackgroundGradientView(budget: budget)
                    .ignoresSafeArea(.all)
                    .zIndex(0)
                
                // Background particles effect
                ParticlesView()
                    .ignoresSafeArea(.all)
                    .opacity(0.4)
                    .zIndex(1)
                
                // Main List Content
                List {
                    // Premium budget header
                    Section {
                        ExpensesListHeaderView(budget: budget, animateProgress: $animateProgress)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    }// Premium budget header
                    
                    // Expenses Section
                    Section {
                        if budget.expenses.isEmpty {
                            ExpenseEmptyStateView()
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                                .opacity(showEmptyState ? 1 : 0)
                                .scaleEffect(showEmptyState ? 1 : 0.8)
                                .animation(.spring(response: 0.8, dampingFraction: 0.8).delay(0.3), value: showEmptyState)
                        } else {
                            ForEach(enumeratedExpenses, id: \.1.id) {index, expense in
                                ExpenseCellView(expense: expense, budget: budget)
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20))
                                    
                            }// ForEach
                        }// if - else
                    } header: {
                        Text("expenses_list_header")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                            .textCase(nil)
                    }
                }// List
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .searchable(text: $searchText, prompt: "search_expenses_prompt")
                .zIndex(2)
                
                
                // Floating Add Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingAddButton(gradientColors: budget.gradientColors)
                            .padding(.trailing, 20)
                            .padding(.bottom, 30)
                    }// HStack
                }// VStack
                .zIndex(3)
            }// ZStack
            .navigationTitle(budget.budgetName)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.2)) {
                    animateProgress = true
                }
                withAnimation(.easeInOut(duration: 0.6).delay(0.5)) {
                    showEmptyState = true
                }
            }// onAppear
        }// NavigationStack
    }// body
    
    // MARK: - Computed Properties
    private var enumeratedExpenses: [(Int, Expense)] {
        Array(filteredExpenses.enumerated())
    }
    
    private var filteredExpenses: [Expense] {
        if searchText.isEmpty {
            return budget.expenses
        } else {
            return budget.expenses.filter { expense in
                expense.expenseName.localizedCaseInsensitiveContains(searchText) ||
                (expense.location.localizedCaseInsensitiveContains(searchText)) ||
                (expense.note?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }
    
}// View

// MARK: - Floating Add Button
struct FloatingAddButton: View {
    let gradientColors: [Color]
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            // TODO: Add logic for adding expense
            print("Add expense tapped")
        }) {
            Image(systemName: "plus")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: gradientColors,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                        .shadow(color: gradientColors.first?.opacity(0.3) ?? .blue.opacity(0.3), radius: 12, x: 0, y: 2)
                )
                .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .pressEvents(
            onPress: { isPressed = true },
            onRelease: { isPressed = false }
        )
        .animation(.easeInOut(duration: 0.15), value: isPressed)
    }
}

// MARK: - Press Events Modifier
extension View {
    func pressEvents(onPress: @escaping () -> Void, onRelease: @escaping () -> Void) -> some View {
        self.simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in onPress() }
                .onEnded { _ in onRelease() }
        )
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
            
            Text("from €\(String(format: "%.0f", budget.totalAmount))")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Preview
#Preview {
    BudgetExpensesListView(budget: Budget(
        budgetName: "Trip in Paris",
        totalAmount: 1500.0,
        spentAmount: 850.0,
        remainingAmount: 650.0,
        creationDate: Date(),
        emoji: "🇫🇷",
        gradientColors: [Color.blue.opacity(0.6), Color.purple.opacity(0.4)],
        expenses: [
            Expense(
                expenseName: "Sample Expense",
                amount: 49.99,
                creationDate: Date(),
                emoji: "🏋️",
                location: "Sample Location",
                quantity: 1,
                note: "Sample note"
            ),
            Expense(
                expenseName: "Another Expense",
                amount: 25.50,
                creationDate: Date().addingTimeInterval(-86400),
                emoji: "🥤",
                location: "Another Location",
                quantity: 2,
                note: nil
            )
        ]
    ))
}
