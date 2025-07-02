//
//  EmptyStateButtonView.swift
//  Iodda
//
//  Created by Vlad on 29/6/25.
//

import SwiftUI

struct EmptyStateButtonView: View {
    // MARK: - Properties
    var buttonName: String
    var action: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack(spacing: 12) {
                Image(systemName: "plus.circle.fill")
                    .font(.title3)
                
                Text(buttonName)
                    .font(.headline)
                    .fontWeight(.semibold)
            }// HStack
            .foregroundStyle(.white)
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.blue)
            )// background
        }// Button
        .buttonStyle(.plain)
    }// body
}// View

// MARK: - Preview
#Preview {
    EmptyStateButtonView(buttonName: "Empty State Button") {}
}
