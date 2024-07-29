//
//  EmptyStateView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 16.07.2024.
//

import SwiftUI

struct EmptyStateView: View {
    var message: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(.emptyStateLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
            
            Text(message)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    EmptyStateView(message: "Empty State Message")
}
