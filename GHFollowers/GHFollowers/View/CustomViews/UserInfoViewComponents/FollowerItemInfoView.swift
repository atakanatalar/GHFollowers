//
//  FollowerItemInfoView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 17.07.2024.
//

import SwiftUI

struct FollowerItemInfoView: View {
    @EnvironmentObject var userManager: UserManager
    @State var isShowingFollowersView: Bool = false
    
    var user: User
    
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
                    userManager.addUsername(to: user.login)
                    isShowingFollowersView = true
                } label: {
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
        .navigationDestination(isPresented: $isShowingFollowersView) { FollowersView() }
    }
}

#Preview {
    FollowerItemInfoView(user: MockData.user)
}
