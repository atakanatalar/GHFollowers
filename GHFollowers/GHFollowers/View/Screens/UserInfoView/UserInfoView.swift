//
//  UserInfoView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 17.07.2024.
//

import SwiftUI

struct UserInfoView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @StateObject var viewModel: UserInfoViewModel
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack() {
                    UserInfoHeaderView(user: viewModel.user, dynamicTypeSize: dynamicTypeSize)
                    RepoItemInfoView(user: viewModel.user, dynamicTypeSize: dynamicTypeSize)
                    FollowerItemInfoView(user: viewModel.user, dynamicTypeSize: dynamicTypeSize)
                    Spacer()
                    
                    Label(UserInfoViewConstants.dateLabelTitle + " \(viewModel.user.createdAt.convertToMonthYearFormat())", systemImage: UserInfoViewConstants.dateLabelImageTitle)
                        .padding()
                }
                .padding(.horizontal)
            }
            if viewModel.isLoading { LoadingView() }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task { await viewModel.getUserInfo(username: viewModel.selectedFollower.login) }
    }
}

#Preview {
    UserInfoView(viewModel: UserInfoView.UserInfoViewModel(selectedFollower: MockData.follower))
}
