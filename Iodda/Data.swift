//
//  Data.swift
//  Iodda
//
//  Created by Vlad on 27/6/25.
//

import SwiftUI
import Observation

/// A data model representing a budget item with all necessary properties.
struct Budget: Identifiable, Hashable {
    let id = UUID() // Unique identifier for each budget item
    let budgetName: String
    let totalAmount: Double
    let spentAmount: Double
    let remainingAmount: Double
    let creationDate: Date
    let emoji: String
    let gradientColors: [Color] // Array of colors for the gradient background
    let currentLanguage: String
    
    /// Computes the progress percentage of spent amount relative to total amount.
    var progressPercentage: Double {
        guard totalAmount > 0 else { return 0 }
        return min(spentAmount / totalAmount, 1.0)
    }
    
    /// Determines if the budget is over the allocated amount.
    var isOverBudget: Bool {
        spentAmount > totalAmount
    }
}

class ApplicationData: ObservableObject {
    @Published var userData: [Budget] {
        didSet {
            filterValues(search: "")
        }
    }

    @Published var filteredBudgets: [Budget] = []

    func filterValues(search: String) {
        if search.isEmpty {
            filteredBudgets = userData.sorted(by: { $0.budgetName < $1.budgetName })
        } else {
            let list = userData.filter { budget in
                return budget.budgetName.localizedStandardContains(search)
            }
            filteredBudgets = list.sorted(by: { $0.budgetName < $1.budgetName })
        }
    }

    static let shared = ApplicationData()
    
    private init() {
        userData = [
            Budget(
                budgetName: "Trip to Paris",
                totalAmount: 500.00,
                spentAmount: 350.00,
                remainingAmount: 150.00,
                creationDate: Date(),
                emoji: "🇫🇷",
                gradientColors: [Color.blue.opacity(0.6), Color.purple.opacity(0.4)],
                currentLanguage: "en"
            ),
            Budget(
                budgetName: "Shopping Spree",
                totalAmount: 200.00,
                spentAmount: 250.00,
                remainingAmount: -50.00,
                creationDate: Date().addingTimeInterval(-86400), // One day ago
                emoji: "🛒",
                gradientColors: [Color.red.opacity(0.6), Color.orange.opacity(0.4)],
                currentLanguage: "en"
            ),
            Budget(
                budgetName: "Gym Membership",
                totalAmount: 100.00,
                spentAmount: 100.00,
                remainingAmount: 0.00,
                creationDate: Date().addingTimeInterval(-172800), // Two days ago
                emoji: "💪",
                gradientColors: [Color.green.opacity(0.6), Color.teal.opacity(0.4)],
                currentLanguage: "en"
            ),
            Budget(
                budgetName: "Unnamed Budget",
                totalAmount: 0.0,
                spentAmount: 0.0,
                remainingAmount: 0.0,
                creationDate: Date(),
                emoji: "💰",
                gradientColors: [Color.gray.opacity(0.3), Color.gray.opacity(0.1)],
                currentLanguage: "en"
            )
        ]
        
        filterValues(search: "")
    }
}
