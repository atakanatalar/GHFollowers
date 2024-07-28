//
//  FollowersView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 15.07.2024.
//

import SwiftUI

struct FollowersView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @StateObject var viewModel: FollowersViewModel
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: viewModel.getColumns(dynamicTypeSize: dynamicTypeSize)) {
                        ForEach(viewModel.filteredFollowers, id: \.self) { follower in
                            NavigationLink(destination: viewModel.createUserInfoView(selectedFollower: follower, dynamicTypeSize: dynamicTypeSize)) {
                                FollowersTitleView(follower: follower)
                            }
                        }
                        
                        if viewModel.hasMoreFollower && !viewModel.followers.isEmpty {
                            FollowersTitleView(follower: Follower(login: FollowersViewConstants.followersTitleViewTitle, avatarUrl: FollowersViewConstants.followersTitleViewAvatarUrl))
                                .onAppear {
                                    Task {
                                        viewModel.page += 1
                                        await viewModel.getFollowers(username: viewModel.selectedUsername, page: viewModel.page)
                                    }
                                }
                        }
                    }
                    .padding()
                    .searchable(text: $viewModel.searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: FollowersViewConstants.searchTitle)
                }
            }
            if viewModel.isEmptyState { EmptyStateView(message: FollowersViewConstants.emptyMessage).padding(.horizontal, 40) }
            if viewModel.isInvalidResponse { EmptyStateView(message: FollowersViewConstants.invalidResponseMessage).padding(.horizontal, 40) }
            if viewModel.isLoading { LoadingView() }
        }
        .navigationTitle(viewModel.selectedUsername)
        .navigationBarTitleDisplayMode(.large)
        .task { await viewModel.getFollowers(username: viewModel.selectedUsername, page: viewModel.page) }
        .onAppear { viewModel.followers = [] }
        .overlay {
            if viewModel.filteredFollowers.isEmpty && !viewModel.followers.isEmpty {
                EmptyStateView(message: FollowersViewConstants.noResultMessageFirst + "\(viewModel.searchTerm)" + FollowersViewConstants.noResultMessageSecond).padding(.horizontal, 40)
            }
        }
    }
}

#Preview {
    FollowersView(viewModel: FollowersView.FollowersViewModel(selectedUsername: ""))
}
