//
//  AppBackgroundGradient.swift
//  Iodda
//
//  Created by Vlad on 27/6/25.
//

import SwiftUI

struct AppBackgroundGradient: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 76/255, green: 175/255, blue: 80/255),  // Зелёный #4CAF50
                    Color(red: 33/255, green: 150/255, blue: 243/255) // Синий #2196F3
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
    }
}

#Preview {
    AppBackgroundGradient()
}
