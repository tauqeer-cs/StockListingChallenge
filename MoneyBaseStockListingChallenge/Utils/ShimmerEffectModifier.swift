//
//  ShimmerEffectModifier.swift
//  MoneyBaseStockListingChallenge
//
//  Created by Tauqeer on 04/04/25.
//


import SwiftUI

struct ShimmerEffectModifier: ViewModifier {
    
    let isActive: Bool
    let radius : CGFloat?
    
    init(isActive: Bool, radius: CGFloat? = nil) {
        self.isActive = isActive
        self.radius = radius
    }
    func body(content: Content) -> some View {
        guard isActive else { return AnyView(content) }
        return AnyView(
            content
                .opacity(0)
                .overlay(ShimmerView().clipped())
                .cornerRadius(radius ?? 8)
        )
    }
}

extension View {
    public dynamic func shimmer(isActive: Bool) -> some View {
        self.modifier(ShimmerEffectModifier(isActive: isActive))
    }
    
    public dynamic func shimmerWithCustomRadius(isActive: Bool,radius : CGFloat) -> some View {
        self.modifier(ShimmerEffectModifier(isActive: true, radius: radius))
    }
}

struct ShimmerView: View {
    @State private var isAnimating: Bool = false
    
    @State private var startPoint: UnitPoint = .init(x: -1.8, y: -1.2)
    @State private var endPoint: UnitPoint = .init(x: 0, y: -0.2)
    
    private let gradientColors = [
        Color.gray.opacity(0.3),
        Color.gray.opacity(0.4),
        Color.gray.opacity(0.5)
    ]
    
    var body: some View {
        LinearGradient(
            colors: gradientColors,
            startPoint: startPoint,
            endPoint: endPoint
        )
        .onAppear(perform: {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) {
                startPoint = .init(x: 1, y: 1)
                endPoint = .init(x: 2.2, y: 2.2)
            }
        })
    }
}
