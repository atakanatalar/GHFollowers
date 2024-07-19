//
//  FollowerItemInfoView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 17.07.2024.
//

import SwiftUI

struct FollowerItemInfoView: View {
    var user: User
    @State var isShowingFollowersView: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    ItemInfoView(itemInfoType: .followers, count: user.followers)
                    Spacer()
                    ItemInfoView(itemInfoType: .following, count: user.following)
                }
                .padding(.top, 24)
                .padding(.horizontal, 12)
                
                Button {
                    isShowingFollowersView = true
                } label: {
                    Label("Get Followers", systemImage: "person.3")
                        .frame(maxWidth: .infinity, maxHeight: 48)
                }
                .modifier(CustomButtonModifier(backgroundColor: Color(.systemGreen)))
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .padding(.vertical, 8)
        }
        .navigationDestination(isPresented: $isShowingFollowersView) { FollowersView(username: user.login) }
    }
}

#Preview {
    FollowerItemInfoView(user: User(login: "", avatarUrl: "", publicRepos: 0, publicGists: 0, htmlUrl: "", following: 0, followers: 0, createdAt: Date.now))
}
