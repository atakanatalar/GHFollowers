//
//  FollowersView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 15.07.2024.
//

import SwiftUI

struct FollowersView: View {
    @StateObject var viewModel: FollowersViewModel
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: viewModel.columns) {
                        ForEach(viewModel.filteredFollowers, id: \.self) { follower in
                            NavigationLink(destination: viewModel.createUserInfoView(selectedFollower: follower)) {
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button() {
                    viewModel.getUserForFavorite(username: viewModel.selectedUsername)
                } label: {
                    Label(FollowersViewConstants.favoriteToolbarButtonTitle, systemImage: FollowersViewConstants.favoriteToolbarButtonImageTitle)
                }
            }
        }
    }
}

#Preview {
    FollowersView(viewModel: FollowersView.FollowersViewModel(selectedUsername: ""))
}
