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
            AvatarView(url: favorite.avatarUrl, height: 60)
            
            Text(favorite.login)
                .font(.title)
                .fontWeight(.bold)
                .lineLimit(1)
        }
    }
}

#Preview {
    FavoritesListCell(favorite: MockData.follower)
}
