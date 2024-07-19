//
//  RepoItemInfoView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 17.07.2024.
//

import SwiftUI

struct RepoItemInfoView: View {
    var user: User
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    ItemInfoView(itemInfoType: .repos, count: user.publicRepos)
                    Spacer()
                    ItemInfoView(itemInfoType: .gists, count: user.publicGists)
                }
                .padding(.top, 24)
                .padding(.horizontal, 12)
                
                Link(destination: (URL(string: user.htmlUrl) ?? URL(string: "https://github.com"))!) {
                    Label("GitHub Profile", systemImage: "person")
                        .frame(maxWidth: .infinity, maxHeight: 48)
                        .modifier(CustomButtonModifier(backgroundColor: Color(.systemPurple)))
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                }
            }
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .padding(.vertical, 8)
        }
    }
}

#Preview {
    RepoItemInfoView(user: User(login: "", avatarUrl: "", publicRepos: 0, publicGists: 0, htmlUrl: "", following: 0, followers: 0, createdAt: Date.now))
}
