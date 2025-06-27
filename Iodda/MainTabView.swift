//
//  MainTabView.swift
//  Iodda
//
//  Created by Vlad on 27/6/25.
//

import SwiftUI

struct MainTabView: View {
    // MARK: - Properties
    @State private var tabPaths: [String: NavigationPath] = [
        "budgets_list": NavigationPath(),
        "pdfs_list": NavigationPath(),
        "settings": NavigationPath()
    ]
    
    // MARK: - Body
    var body: some View {
        TabView {
            Tab("budgets_list_view_navigationTitle", systemImage: "list.bullet.rectangle") {
                NavigationStack(path: pathBinding(for: "budgets_list")) {
                    BudgetsListView()
                        .navigationTitle("budgets_list_view_navigationTitle")
                }
            }// Budgets List Tab
            
            Tab("pdfs_list_view_navigationTitle", systemImage: "doc.on.clipboard") {
                NavigationStack(path: pathBinding(for: "pdfs_list")) {
                    PdfListView()
                        .navigationTitle("pdfs_list_view_navigationTitle")
                }
            }// PDF'S List Tab
            
            Tab("settings_view_navigationTitle", systemImage: "gear.badge") {
                NavigationStack(path: pathBinding(for: "settings")) {
                    SettingsView()
                        .navigationTitle("settings_view_navigationTitle")
                }
            }// Settings Tab
        }// TabView
    }// Body
    
    // MARK: - Methods
    private func pathBinding(for key: String) -> Binding<NavigationPath> {
        Binding<NavigationPath>(
            get: { tabPaths[key] ?? NavigationPath() },
            set: { tabPaths[key] = $0 }
        )
    }// pathBinding func
    
}// View

// MARK: - Preview
#Preview {
    MainTabView()
}
