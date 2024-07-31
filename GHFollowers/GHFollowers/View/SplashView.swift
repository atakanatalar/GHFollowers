//
//  SplashView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 22.07.2024.
//

import SwiftUI

struct SplashView: View {
    @Binding var isPresented: Bool
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    @State private var offset = CGSize.zero
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                
                LogoView(frameWidth: 120)
                    .scaleEffect(scale)
                    .offset(offset)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1)) {
                            scale = CGSize(width: 1.5, height: 1.5)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            let topPadding = 96.0
                            let logoCenter = 120.0 * 1.5 / 2.0
                            let targetOffsetY = -(geometry.size.height / 2 - (topPadding + logoCenter))
                            withAnimation(.easeInOut(duration: 0.5)) { offset = CGSize(width: 0, height: targetOffsetY) }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.easeIn(duration: 0.5)) { isPresented.toggle() }
                        }
                    }
                    .accessibilityLabel(SplashViewConstants.accessibilityLabelAppLogo)
            }
        }
    }
}

#Preview {
    SplashView(isPresented: .constant(true))
}
