//
//  ExpenseEmptyStateView.swift
//  Iodda
//
//  Created by Vlad on 29/6/25.
//

import SwiftUI

struct ExpenseEmptyStateView: View {
    // MARK: - Properties
    @State private var animateIcon = false
    @State private var isAnimating = false
    @State private var showContent = false
    @State private var floatingOffset: CGFloat = 0

    // MARK: - Body
    var body: some View {
        VStack(spacing: 40) {
            // Empty state content
            emptyStateContent
                .opacity(showContent ? 1 : 0)
                .offset(y: showContent ? 0 : 20)
                .animation(.easeOut(duration: 0.6).delay(0.3), value: showContent)
        }// VStack
        .padding(.horizontal, 24)
        .padding(.top, 60)
        .onAppear {
            showContent = true
            animateIcon = true
        }// onAppear
    }// View

    // MARK: - Components
    private var emptyStateContent: some View {
        VStack(spacing: 24) {
            // Glowing icon
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Color.blue.opacity(0.2), Color.clear],
                            center: .center,
                            startRadius: 15,
                            endRadius: 50
                        )
                    )
                    .frame(width: 80, height: 80)
                    .scaleEffect(animateIcon ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animateIcon)

                Image(systemName: "creditcard")
                    .font(.system(size: 32, weight: .light))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }// ZStack

            VStack(spacing: 20) {
                VStack(spacing: 12) {
                    Text("No expenses yet")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.center)

                    Text("Start tracking your spending\nand control your budget")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }// VStack

                EmptyStateButtonView(buttonName: "Add first expense") {
                    // Add expense logic
                }// EmptyStateButtonView
            }// VStack
        }.onAppear {
            isAnimating = true
            floatingOffset = -5
        }// onAppear
    }// emptyStateContent
}// View

// MARK: - Preview
#Preview {
    ExpenseEmptyStateView()
}
