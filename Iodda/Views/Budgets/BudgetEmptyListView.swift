//
//  BudgetEmptyListView.swift
//  Iodda
//
//  Created by Vlad on 28/6/25.
//

import SwiftUI

struct BudgetEmptyListView: View {
    // MARK: - Properties
    @State private var isAnimating = false
    @State private var floatingOffset: CGFloat = 0
        
    // MARK: - Body
    var body: some View {
        VStack(spacing: 32) {
            // Animated floating card
            ZStack {
                
                // Background with glassmorphism effect
                RoundedRectangle(cornerRadius: 24)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.blue.opacity(0.4),
                                Color.purple.opacity(0.3),
                                Color.teal.opacity(0.2)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )// LinearGradient
                    )// fill
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.3), Color.clear],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )// stroke
                    )// overlay
                    .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
                
                // Floating emoji with backdrop blur
                VStack {
                    HStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .fill(.ultraThinMaterial)
                                .frame(width: 70, height: 70)
                                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                            
                            Text("💰")
                                .font(.system(size: 40))
                                .scaleEffect(isAnimating ? 1.1 : 1.0)
                                .animation(
                                    .easeInOut(duration: 2)
                                    .repeatForever(autoreverses: true),
                                    value: isAnimating
                                )
                        }// ZStack
                        .padding(.top, 8)
                        .padding(.trailing, 20)
                    }// HStack
                    Spacer()
                }// VStack
                
                // Content
                VStack(spacing: 20) {
                    // Header section
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("your_first_budget")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                                .padding(.trailing, 80)
                            
                            HStack(spacing: 6) {
                                Image(systemName: "sparkles")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                                Text("start_tracking_expenses")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }// VStack
                        Spacer()
                    }// HStack
                    
                    // Progress section (placeholder)
                    VStack(spacing: 16) {
                        // Placeholder progress bar
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.black.opacity(0.1))
                                .frame(height: 6)
                            
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    LinearGradient(
                                        colors: [.green.opacity(0.3), .teal.opacity(0.3)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )// LinearGradient
                                )// fill
                                .frame(width: 0, height: 6)
                        }// ZStack
                        .frame(maxWidth: .infinity)
                        
                        // Placeholder amount info cards
                        HStack(spacing: 6) {
                            PlaceholderAmountCard(
                                title: "total_amount",
                                icon: "creditcard.fill",
                                color: .blue
                            )
                            
                            PlaceholderAmountCard(
                                title: "spent",
                                icon: "minus.circle.fill",
                                color: .orange
                            )
                            
                            PlaceholderAmountCard(
                                title: "remaining",
                                icon: "plus.circle.fill",
                                color: .green
                            )
                        }// HStack
                    }// VStack
                }// VStack
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
            }// ZStack
            .frame(height: 160)
            .offset(y: floatingOffset)
            .animation(
                .easeInOut(duration: 3)
                .repeatForever(autoreverses: true),
                value: floatingOffset
            )// animation
            
            // Call to action section
            VStack(spacing: 20) {
                VStack(spacing: 12) {
                    Text("no_budgets_yet")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.center)
                    
                    Text("lets_get_it_started")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }// VStack
                
                // Create budget button
                Button(action: {
                    // TODO: Handle create budget action
                    print("Create first budget tapped")
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                        
                        Text("create_first_budget")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }// HStack
                    .foregroundStyle(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    .background(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        in: RoundedRectangle(cornerRadius: 16)
                    )// background
                    .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                }// Button
                .scaleEffect(isAnimating ? 1.05 : 1.0)
                .animation(
                    .easeInOut(duration: 2.5)
                    .repeatForever(autoreverses: true),
                    value: isAnimating
                )// animation
            }// VStack
        }// VStack
        .padding(.horizontal, 20)
        .onAppear {
            isAnimating = true
            floatingOffset = -5
        }// onAppear
    }// body
}// View

// MARK: - PlaceholderAmountCard SubView
struct PlaceholderAmountCard: View {
    // MARK: - Properties
    let title: LocalizedStringKey
    let icon: String
    let color: Color
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.caption2)
                    .foregroundStyle(color.opacity(0.6))
                
                Text(title)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }// HStack
            
            Text("--")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.primary.opacity(0.5))
        }// VStack
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial.opacity(0.7), in: RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(color.opacity(0.2), lineWidth: 0.5)
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
