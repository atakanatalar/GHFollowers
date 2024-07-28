//
//  FollowerTitleView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 15.07.2024.
//

import SwiftUI

struct FollowersTitleView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let follower: Follower
    
    var body: some View {
        VStack(spacing: 12) {
            AvatarView(url: follower.avatarUrl)
            
            Text(follower.login)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .lineLimit(1)
        }
    }
}

#Preview {
    FollowersTitleView(follower: MockData.follower)
}
