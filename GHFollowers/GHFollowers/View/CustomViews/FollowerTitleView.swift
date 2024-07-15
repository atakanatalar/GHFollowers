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
            Image(.avatarPlaceholder)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(follower.login)
                .font(.body)
                .fontWeight(.semibold)
                .lineLimit(1)
        }
    }
}

#Preview {
    FollowersTitleView(follower: Follower(login: "login", avatarUrl: "url"))
}
