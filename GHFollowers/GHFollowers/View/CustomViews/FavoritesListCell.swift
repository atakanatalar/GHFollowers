//
//  FavoritesListCell.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 19.07.2024.
//

import SwiftUI

struct FavoritesListCell: View {
    let favorite: Follower
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: favorite.avatarUrl)) { phase in
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
            .frame(width: 60)
            
            Text(favorite.login)
                .font(.title)
                .fontWeight(.bold)
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
    FavoritesListCell(favorite: Follower(login: "login", avatarUrl: ""))
}
