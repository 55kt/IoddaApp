//
//  AddExpenseView.swift
//  Iodda
//
//  Created by Vlad on 29/6/25.
//

import SwiftUI

struct AddExpenseView: View {
    // MARK: - Properties
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                // Basic Information Section
                Section("Basic Information") {
                    // Expense Name
                    HStack {
                        Text("expense_name")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text("Default Name") // Замена TextField
                            .textFieldStyle(.plain)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    // Amount
                    HStack {
                        Text("amount")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text("0.00") // Замена TextField
                            .textFieldStyle(.plain)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    // Emoji Selection
                    HStack {
                        Text("Icon")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        HStack {
                            Text("💰") // Дефолтный эмодзи
                                .font(.title2)
                            
                            Image(systemName: "chevron.down")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                // Details Section
                Section("Details") {
                    // Location
                    HStack {
                        Text("location")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text("Default Location") // Замена TextField
                            .textFieldStyle(.plain)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    // Date
                    HStack {
                        Text("Date")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text("Today") // Дефолтная дата
                    }
                    
                    // Quantity
                    HStack {
                        Text("quantity")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text("1") // Дефолтное значение
                            .foregroundStyle(.primary)
                    }
                    
                    // Category
                    HStack {
                        Text("category")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        HStack {
                            Text("Default Category") // Дефолтное значение
                                .foregroundStyle(.primary)
                            
                            Image(systemName: "chevron.down")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                // Notes Section
                Section("Notes") {
                    Text("Default Note") // Замена TextField
                        .multilineTextAlignment(.leading)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            // Убираем toolbar
        }
    }
    
    // MARK: - Methods
    // Убираем методы, так как они не нужны
}

// MARK: - Preview
#Preview {
    NavigationStack {
        AddExpenseView()
    }
    // Убираем environmentObject
}
