//
//  ParticlesView.swift
//  Iodda
//
//  Created by Vlad on 30/6/25.
//

import SwiftUI

struct ParticlesView: View {
    @State private var animate = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<12, id: \.self) { i in
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color.blue.opacity(0.08), Color.clear],
                                center: .center,
                                startRadius: 1,
                                endRadius: 8
                            )
                        )
                        .frame(width: CGFloat.random(in: 3...8))
                        .position(
                            x: animate ? CGFloat.random(in: 0...geometry.size.width) : CGFloat.random(in: 0...geometry.size.width),
                            y: animate ? CGFloat.random(in: 0...geometry.size.height) : CGFloat.random(in: 0...geometry.size.height)
                        )
                        .animation(
                            .linear(duration: Double.random(in: 8...15))
                            .repeatForever(autoreverses: true)
                            .delay(Double.random(in: 0...3)),
                            value: animate
                        )
                }
            }
            .onAppear {
                animate = true
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        ParticlesView()
            .frame(width: 300, height: 300)
            .overlay(
                Text("Particles Animation (12 circles moving randomly)")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(5)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(5)
                    .offset(y: -140)
            )
    }
}
