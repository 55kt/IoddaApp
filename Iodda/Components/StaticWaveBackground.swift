//
//  StaticWaveBackground.swift
//  Iodda
//
//  Created by Vlad on 28/6/25.
//

import SwiftUI

struct StaticWaveBackground: View {
    // MARK: - Body
    var body: some View {
        ZStack {
            // Base gradient background
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.1),
                    Color.purple.opacity(0.05),
                    Color.teal.opacity(0.08)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea(.all)
            
            // Static wave layers
            StaticWaveShape(frequency: 0.8, amplitude: 30, phase: 0)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.blue.opacity(0.3),
                            Color.purple.opacity(0.2)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .ignoresSafeArea(.all)
            
            StaticWaveShape(frequency: 1.2, amplitude: 20, phase: .pi / 3)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.purple.opacity(0.25),
                            Color.teal.opacity(0.2)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .ignoresSafeArea(.all)
            
            StaticWaveShape(frequency: 0.6, amplitude: 40, phase: .pi / 2)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.teal.opacity(0.2),
                            Color.blue.opacity(0.15)
                        ],
                        startPoint: .bottomLeading,
                        endPoint: .topTrailing
                    )
                )
                .ignoresSafeArea(.all)
            
            // Overlay for subtle texture
            Rectangle()
                .fill(.ultraThinMaterial.opacity(0.2))
                .ignoresSafeArea(.all)
                .blendMode(.overlay)
        }
    }
}

// MARK: - Static Wave Shape
struct StaticWaveShape: Shape {
    var frequency: Double
    var amplitude: CGFloat
    var phase: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let midHeight = height * 0.7
        
        path.move(to: CGPoint(x: 0, y: midHeight))
        
        for x in stride(from: 0, through: width, by: 2) {
            let relativeX = x / width
            let normalizedX = relativeX * frequency * 2 * .pi
            let y = sin(normalizedX + phase) * amplitude + midHeight
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}

// MARK: - Alternative Floating Orbs Background
struct FloatingOrbsBackground: View {
    @State private var orb1Position: CGSize = .zero
    @State private var orb2Position: CGSize = .zero
    @State private var orb3Position: CGSize = .zero
    @State private var orb1Scale: CGFloat = 1.0
    @State private var orb2Scale: CGFloat = 1.0
    @State private var orb3Scale: CGFloat = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Base background
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.05),
                        Color.purple.opacity(0.03),
                        Color.teal.opacity(0.04)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Floating orbs
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.blue.opacity(0.4),
                                Color.blue.opacity(0.1),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 0,
                            endRadius: 150
                        )
                    )
                    .frame(width: 300, height: 300)
                    .offset(orb1Position)
                    .scaleEffect(orb1Scale)
                    .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.2)
                    .blur(radius: 20)
                
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.purple.opacity(0.35),
                                Color.purple.opacity(0.1),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 0,
                            endRadius: 120
                        )
                    )
                    .frame(width: 240, height: 240)
                    .offset(orb2Position)
                    .scaleEffect(orb2Scale)
                    .position(x: geometry.size.width * 0.2, y: geometry.size.height * 0.7)
                    .blur(radius: 15)
                
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.teal.opacity(0.3),
                                Color.teal.opacity(0.08),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 0,
                            endRadius: 100
                        )
                    )
                    .frame(width: 200, height: 200)
                    .offset(orb3Position)
                    .scaleEffect(orb3Scale)
                    .position(x: geometry.size.width * 0.6, y: geometry.size.height * 0.9)
                    .blur(radius: 25)
            }
        }
        .onAppear {
            startOrbAnimations()
        }
    }
    
    private func startOrbAnimations() {
        // Orb 1 animation
        withAnimation(
            .easeInOut(duration: 8)
            .repeatForever(autoreverses: true)
        ) {
            orb1Position = CGSize(width: -50, height: 30)
            orb1Scale = 1.2
        }
        
        // Orb 2 animation
        withAnimation(
            .easeInOut(duration: 10)
            .repeatForever(autoreverses: true)
        ) {
            orb2Position = CGSize(width: 40, height: -20)
            orb2Scale = 0.9
        }
        
        // Orb 3 animation
        withAnimation(
            .easeInOut(duration: 12)
            .repeatForever(autoreverses: true)
        ) {
            orb3Position = CGSize(width: -30, height: -40)
            orb3Scale = 1.1
        }
    }
}

// MARK: - Background Container View
struct AppBackground: View {
    enum BackgroundStyle {
        case staticWaves
        case orbs
    }
    
    let style: BackgroundStyle
    
    var body: some View {
        switch style {
        case .staticWaves:
            StaticWaveBackground()
        case .orbs:
            FloatingOrbsBackground()
        }
    }
}

// MARK: - Preview
#Preview("Static Wave Background") {
    ZStack {
        AppBackground(style: .staticWaves)
        
        VStack {
            Text("Static Wave Background")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            
            Text("Beautiful static waves that cover the entire screen")
                .font(.title3)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
    }
}

#Preview("Orbs Background") {
    ZStack {
        AppBackground(style: .orbs)
        
        VStack {
            Text("Floating Orbs")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            
            Text("Subtle floating elements")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}
