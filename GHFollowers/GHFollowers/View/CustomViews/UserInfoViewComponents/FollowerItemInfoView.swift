//
//  FollowerItemInfoView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 17.07.2024.
//

import SwiftUI

struct FollowerItemInfoView: View {
    @State var isShowingFollowersView: Bool = false
    
    let user: User
    let dynamicTypeSize: DynamicTypeSize
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    if dynamicTypeSize >= .accessibility1 {
                        bigSizeInfoViews
                    } else {
                        normalSizeInfoViews
                    }
                    
                    NavigationLink(destination: FollowersView(viewModel: FollowersView.FollowersViewModel(selectedUsername: user.login))) {
                        Label(FollowersItemInfoViewConstants.getFollowersButtonTitle, systemImage: FollowersItemInfoViewConstants.getFollowersButtonImageTitle)
                            .frame(maxWidth: .infinity)
                            .frame(height: dynamicTypeSize >= .accessibility1 ? 72 : 48)
                    }
                    .modifier(CustomButtonModifier(backgroundColor: Color(.systemGreen)))
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                    .accessibilityHint(FollowersItemInfoViewConstants.accessibilityHintFollowers)
                }
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .padding(.vertical, 8)
            }
        }
    }
    
    var normalSizeInfoViews: some View {
        HStack {
            ItemInfoView(itemInfoType: .followers, count: user.followers)
            Spacer()
            ItemInfoView(itemInfoType: .following, count: user.following)
        }
        .padding(.top, 24)
        .padding(.horizontal, 12)
    }
    
    var bigSizeInfoViews: some View {
        VStack(alignment: .center) {
            ItemInfoView(itemInfoType: .followers, count: user.followers)
            ItemInfoView(itemInfoType: .following, count: user.following)
        }
        .padding(.top, 24)
        .padding(.horizontal, 12)
    }
}

#Preview {
    FollowerItemInfoView(user: MockData.user, dynamicTypeSize: .medium)
}
