//
//  FavoritesView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 13.07.2024.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        ZStack {
            List(viewModel.favorites, id: \.self) { favorite in
                NavigationLink(destination: viewModel.createFollowersView(selectedUsername: favorite.login)) {
                    FavoritesListCell(favorite: favorite)
                        .accessibilityHint(FavoritesViewConstants.accessibilityHintListCell)
                        .swipeActions {
                            Button(role: .destructive) {
                                viewModel.removeFromFavorites(favorite: favorite)
                            } label: {
                                Label(FavoritesViewConstants.swipeDeleteButtonTitle, systemImage: FavoritesViewConstants.swipeDeleteButtonImageTitle)
                            }
                        }
                }
            }
            .listStyle(.plain)
            
            if viewModel.isEmptyState { EmptyStateView(message: FavoritesViewConstants.emptyMessage).padding(.horizontal, 40) }
        }
        .navigationTitle(FavoritesViewConstants.navigationTitle)
        .onAppear {
            viewModel.getFavorites()
        }
        .refreshable {
            viewModel.getFavorites()
        }
    }
}

#Preview {
    FavoritesView()
}
