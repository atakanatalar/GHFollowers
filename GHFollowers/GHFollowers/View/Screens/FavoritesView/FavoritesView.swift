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
            NavigationStack {
                List(viewModel.favorites, id: \.self) { favorite in
                    NavigationLink(destination: viewModel.createUserInfoView(selectedFavorite: favorite, dynamicTypeSize: dynamicTypeSize )) {
                        FavoritesListCell(favorite: favorite)
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
                .navigationTitle(FavoritesViewConstants.navigationTitle)
            }
            if viewModel.isEmptyState { EmptyStateView(message: FavoritesViewConstants.emptyMessage).padding(.horizontal, 40) }
        }
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
