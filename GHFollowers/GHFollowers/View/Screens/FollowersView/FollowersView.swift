//
//  FollowersView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 15.07.2024.
//

import SwiftUI

struct FollowersView: View {
    @EnvironmentObject var userManager: UserManager
    @StateObject private var viewModel = FollowersViewModel()
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: viewModel.columns) {
                        ForEach(viewModel.filteredFollowers, id: \.self) { follower in
                            FollowersTitleView(follower: follower)
                                .onTapGesture {
                                    userManager.addUsername(to: follower.login)
                                    viewModel.isShowingUserInfoView = true
                                }
                        }
                        
                        if viewModel.hasMoreFollower && !viewModel.followers.isEmpty {
                            FollowersTitleView(follower: Follower(login: FollowersViewConstants.followersTitleViewTitle, avatarUrl: FollowersViewConstants.followersTitleViewAvatarUrl))
                                .onAppear {
                                    Task {
                                        viewModel.page += 1
                                        await viewModel.getFollowers(username: userManager.usernames.last ?? "username", page: viewModel.page)
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
        .navigationTitle(viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.large)
        .interactiveDismissDisabled()
        .task { await viewModel.getFollowers(username: userManager.usernames.last ?? "username", page: viewModel.page) }
        .sheet(isPresented: $viewModel.isShowingUserInfoView) {
            NavigationStack {
                viewModel.createUserInfoView()
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(FollowersViewConstants.userInfoViewToolbarButtonTitle) {
                                viewModel.isShowingUserInfoView = false
                            }
                        }
                    }
            }
        }
        .onAppear {
            viewModel.navigationTitle = userManager.usernames.last ?? ""
            viewModel.followers = []
        }
        .overlay {
            if viewModel.filteredFollowers.isEmpty && !viewModel.followers.isEmpty {
                EmptyStateView(message: FollowersViewConstants.noResultMessageFirst + "\(viewModel.searchTerm)" + FollowersViewConstants.noResultMessageSecond).padding(.horizontal, 40)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button() {
                    viewModel.getUserForFavorite(username: userManager.usernames.last ?? "username")
                } label: {
                    Label(FollowersViewConstants.favoriteToolbarButtonTitle, systemImage: FollowersViewConstants.favoriteToolbarButtonImageTitle)
                }
            }
        }
    }
}

#Preview {
    FollowersView()
}
