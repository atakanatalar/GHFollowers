//
//  FollowerItemInfoView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 17.07.2024.
//

import SwiftUI

struct FollowerItemInfoView: View {
    @State var isShowingFollowersView: Bool = false
    var user: User
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    HStack {
                        ItemInfoView(itemInfoType: .followers, count: user.followers)
                        Spacer()
                        ItemInfoView(itemInfoType: .following, count: user.following)
                    }
                    .padding(.top, 24)
                    .padding(.horizontal, 12)
                    
                    NavigationLink(destination: FollowersView(viewModel: FollowersView.FollowersViewModel(selectedUsername: user.login))) {
                        Label(FollowersItemInfoViewConstants.getFollowersButtonTitle, systemImage: FollowersItemInfoViewConstants.getFollowersButtonImageTitle)
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
        }
    }
}

#Preview {
    FollowerItemInfoView(user: MockData.user)
}
