//
//  LoadingView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 15.07.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(0.9)
                .ignoresSafeArea(.all)
        
            VStack(spacing: 16) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color(.systemGreen)))
                    .scaleEffect(1.5)
                
                Text(LoadingViewConstants.loadingText)
                    .foregroundStyle(Color(.systemGreen))
            }
            .offset(y: -40)
        }
    }
}

#Preview {
    LoadingView()
}
