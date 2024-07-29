//
//  AvatarView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 27.07.2024.
//

import SwiftUI

struct AvatarView: View {
    let url: String
    var height: CGFloat?
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                placeholderImageView
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: height)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            case .failure:
                placeholderImageView
            @unknown default:
                placeholderImageView
            }
        }
    }
    
    var placeholderImageView: some View {
        Image(.avatarPlaceholder)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: height)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    LogoView(frameWidth: 200)
}
