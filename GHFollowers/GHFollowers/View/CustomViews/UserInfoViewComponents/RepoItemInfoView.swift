//
//  RepoItemInfoView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 17.07.2024.
//

import SwiftUI

struct RepoItemInfoView: View {
    let user: User
    let dynamicTypeSize: DynamicTypeSize
    
    var body: some View {
        ZStack {
            VStack {
                if dynamicTypeSize >= .accessibility1 {
                    bigSizeInfoViews
                } else {
                    normalSizeInfoViews
                }
                
                Link(destination: (URL(string: user.htmlUrl) ?? URL(string: "https://github.com"))!) {
                    Label(RepoItemInfoViewConstants.gitHubProfileButtonTitle, systemImage: RepoItemInfoViewConstants.gitHubProfileButtonImageTitle)
                        .frame(maxWidth: .infinity)
                        .frame(height: dynamicTypeSize >= .accessibility1 ? 72 : 48)
                }
                .modifier(CustomButtonModifier(backgroundColor: Color(.systemPurple)))
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .padding(.vertical, 8)
        }
    }
    
    var normalSizeInfoViews: some View {
        HStack {
            ItemInfoView(itemInfoType: .repos, count: user.publicRepos)
            Spacer()
            ItemInfoView(itemInfoType: .gists, count: user.publicGists)
        }
        .padding(.top, 24)
        .padding(.horizontal, 12)
    }
    
    var bigSizeInfoViews: some View {
        VStack(alignment: .center) {
            ItemInfoView(itemInfoType: .repos, count: user.publicRepos)
            ItemInfoView(itemInfoType: .gists, count: user.publicGists)
        }
        .padding(.top, 24)
        .padding(.horizontal, 12)
    }
}

#Preview {
    RepoItemInfoView(user: MockData.user, dynamicTypeSize: .medium)
}
