//
//  BudgetEmptyListView.swift
//  Iodda
//
//  Created by Vlad on 28/6/25.
//

import SwiftUI

struct BudgetEmptyListView: View {
    // MARK: - Properties
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 32) {
            // Professional budget preview card
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .stroke(
                    Color(.systemGray4).opacity(colorScheme == .dark ? 0.3 : 0.6),
                    lineWidth: 0.5
                )
                .overlay(
                    VStack(spacing: 16) {
                        // Header section matching BudgetCellView
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                HStack(spacing: 20) {
                                    // Clean emoji display
                                    Text("💰")
                                        .font(.system(size: 50))
                                        .background(
                                            Circle()
                                                .fill(Color(.systemBackground))
                                                .opacity(colorScheme == .dark ? 0.3 : 0.8)
                                                .frame(width: 70, height: 70)
                                        )
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("your_first_budget")
                                            .font(.system(size: 20))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.primary)
                                            .lineLimit(1)
                                        
                                        HStack(spacing: 7) {
                                            Image(systemName: "sparkles")
                                                .font(.title2)
                                                .foregroundStyle(.secondary)
                                            
                                            Text("start_tracking_expenses")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }// HStack
                                    }// VStack
                                }// HStack
                            }// VStack
                            .padding(.top, 20)
                            
                            Spacer()
                            
                            // Placeholder status indicator
                            VStack(alignment: .trailing, spacing: 4) {
                                Image(systemName: "plus.circle")
                                    .foregroundStyle(.blue)
                                    .font(.title3)
                                
                                Text("0%")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.secondary)
                            }// VStack
                        }// HStack
                        
                        // Placeholder progress bar
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color(.systemGray5))
                                .frame(height: 8)
                            
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.blue.opacity(0.3))
                                .frame(width: 0, height: 8)
                        }// ZStack
                        .frame(maxWidth: .infinity)
                        
                        // Placeholder amount cards matching BudgetCellView style
                        HStack(spacing: 12) {
                            PlaceholderAmountCard(
                                title: "Total",
                                icon: "creditcard",
                                color: .blue
                            )
                            
                            PlaceholderAmountCard(
                                title: "Spent",
                                icon: "minus.circle",
                                color: .orange
                            )
                            
                            PlaceholderAmountCard(
                                title: "Left",
                                icon: "plus.circle",
                                color: .green
                            )
                        }// HStack
                    }// VStack
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                )
                .frame(height: 200)
            
            // Call to action section
            VStack(spacing: 20) {
                VStack(spacing: 12) {
                    Text("no_budgets_yet")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.center)
                    
                    Text("lets_get_it_started")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }// VStack
                
                // Create budget button
                EmptyStateButtonView(buttonName: "Add your first budget") {}
                
            }// VStack
        }// VStack
        .padding(.horizontal, 20)
    }// body
}// View

// MARK: - PlaceholderAmountCard SubView
struct PlaceholderAmountCard: View {
    // MARK: - Properties
    let title: String
    let icon: String
    let color: Color
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundStyle(color)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }// HStack
            
            Text("--")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.primary.opacity(0.5))
        }// VStack
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemGray6).opacity(colorScheme == .dark ? 0.3 : 0.8))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.systemGray4).opacity(0.5), lineWidth: 0.5)
        )// overlay
    }// body
}// View

// MARK: - Preview
#Preview {
    NavigationStack {
        BudgetEmptyListView()
            .navigationTitle("Budgets")
    }
    .background(Color(.systemGroupedBackground))
}
