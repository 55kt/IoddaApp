//
//  BudgetsListView.swift
//  Iodda
//
//  Created by Vlad on 27/6/25.
//

import SwiftUI

struct BudgetsListView: View {
    // MARK: - Properties
    @State private var budgets = BudgetData.sampleBudgets
    
    // MARK: - Body
    var body: some View {
        List(budgets) { budget in
            BudgetCellView(
                budgetName: budget.budgetName,
                totalAmount: budget.totalAmount,
                spentAmount: budget.spentAmount,
                remainingAmount: budget.remainingAmount,
                creationDate: budget.creationDate,
                emoji: budget.emoji,
                gradientColors: budget.gradientColors,
                currentLanguage: budget.currentLanguage
            )
            .listStyle(.plain)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }// List
    }// Body
}// View

// MARK: - Preview
#Preview {
    NavigationStack {
        BudgetsListView()
            .navigationTitle("Budgets")
    }
}
