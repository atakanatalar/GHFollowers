//
//  FavoritesView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 13.07.2024.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var userManager: UserManager
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        ZStack {
            NavigationStack {
                List(viewModel.favorites, id: \.self) { favorite in
                    FavoritesListCell(favorite: favorite)
                        .onTapGesture {
                            userManager.addUsername(to: favorite.login)
                            viewModel.isShowingUserInfoView = true
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                viewModel.removeFromFavorites(favorite: favorite)
                            } label: {
                                Label(FavoritesViewConstants.swipeDeleteButtonTitle, systemImage: FavoritesViewConstants.swipeDeleteButtonImageTitle)
                            }
                        }
                }
                .listStyle(.plain)
                .navigationTitle(FavoritesViewConstants.navigationTitle)
            }
            if viewModel.isEmptyState { EmptyStateView(message: FavoritesViewConstants.emptyMessage).padding(.horizontal, 40) }
        }
        .onAppear {
            viewModel.getFavorites()
        }
        .sheet(isPresented: $viewModel.isShowingUserInfoView) {
            NavigationStack {
                UserInfoView()
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(FavoritesViewConstants.userInfoViewToolbarButtonTitle) {
                                viewModel.isShowingUserInfoView = false
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    FavoritesView()
}