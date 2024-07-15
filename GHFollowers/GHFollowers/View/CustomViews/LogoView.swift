//
//  LogoView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 15.07.2024.
//

import SwiftUI

struct LogoView: View {
    var frameWidth: CGFloat
    
    var body: some View {
        Image(.ghLogo)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: frameWidth)
    }
}

#Preview {
    LogoView(frameWidth: 200)
}
