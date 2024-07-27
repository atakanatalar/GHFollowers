//
//  FollowerTitleView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 15.07.2024.
//

import SwiftUI

struct FollowersTitleView: View {
    let follower: Follower
    
    var body: some View {
        VStack(spacing: 12) {
            AsyncImage(url: URL(string: follower.avatarUrl)) { phase in
                switch phase {
                case .empty:
                    PlaceholderImageView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                case .failure:
                    PlaceholderImageView()
                @unknown default:
                    PlaceholderImageView()
                }
            }
            
            Text(follower.login)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .lineLimit(1)
        }
    }
    
    struct PlaceholderImageView: View {
        var body: some View {
            Image(.avatarPlaceholder)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    FollowersTitleView(follower: MockData.follower)
}
