//
//  BudgetsListView.swift
//  Iodda
//
//  Created by Vlad on 27/6/25.
//

import SwiftUI

struct BudgetsListView: View {
    // MARK: - Properties
    @EnvironmentObject var appData: ApplicationData
    @State private var searchText: String = ""
    
    // MARK: - Body
    var body: some View {
        ZStack {
            
            IoddaLogo(logoSize: 200, logoOpacity: 0.5, showAppName: false)
                .ignoresSafeArea()
                .zIndex(0)
            
            List {
                ForEach(appData.filteredBudgets) { budget in
                    BudgetCellView(budget: budget)
                }// ForEach
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }// List
            .listStyle(.plain)
            .searchable(text: $searchText)
            .onChange(of: searchText, initial: false) { oldValue, value in
                let search = value.trimmingCharacters(in: .whitespaces)
                appData.filterValues(search: search)
            }// onChange
            .zIndex(1)
        }// ZStack
    }// Body
}// View

// MARK: - Preview
#Preview {
    NavigationStack {
        BudgetsListView()
            .navigationTitle("Budgets")
            .environmentObject(ApplicationData.shared)
    }
}
