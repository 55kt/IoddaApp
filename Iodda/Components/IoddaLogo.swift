//
//  IoddaLogo.swift
//  Iodda
//
//  Created by Vlad on 28/6/25.
//

import SwiftUI

struct IoddaLogo: View {
    let logoSize: CGFloat
    let showAppName: Bool
    let logoOpacity: Double
    
    init(logoSize: CGFloat = 120, logoOpacity: Double = 1.0, showAppName: Bool = true) {
        self.logoSize = logoSize
        self.logoOpacity = logoOpacity
        self.showAppName = showAppName
    }
    
    var body: some View {
        ZStack {
            // Background waves
            AppBackground(style: .staticWaves)
            
            // Logo centered
            VStack(spacing: 2) {
                Image("applogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: logoSize * 1.2)
                    .opacity(logoOpacity)
                
                if showAppName {
                    VStack(spacing: 8) {
                        Text("Iodda")
                            .font(.system(size: logoSize * 0.35, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color.blue, Color.purple, Color.teal],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        Text("Budget Reports Made Simple")
                            .font(.system(size: logoSize * 0.12, weight: .medium, design: .rounded))
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
            }
        }
    }
}

// MARK: - Preview
#Preview("Logo with Background") {
    IoddaLogo(logoSize: 150, showAppName: true)
}

#Preview("Logo without App Name") {
    IoddaLogo(logoSize: 120, showAppName: false)
}

#Preview("Different Sizes") {
    VStack(spacing: 30) {
        IoddaLogo(logoSize: 100, showAppName: true)
        IoddaLogo(logoSize: 80, showAppName: false)
    }
}
