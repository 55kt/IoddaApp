//
//  AmountCard.swift
//  Iodda
//
//  Created by Vlad on 1/7/25.
//

import SwiftUI

struct AmountCard: View {
    let title: String
    let amount: Double
    let icon: String
    let color: Color
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.caption2)
                    .foregroundStyle(color)
                
                Text(title)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
            
            Text(formattedCurrency(amount: amount))
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemGray6).opacity(colorScheme == .dark ? 0.2 : 0.6))
        )
    }
}

#Preview {
    AmountCard(title: "Amount Card", amount: 1000, icon: "", color: Color.blue)
}
