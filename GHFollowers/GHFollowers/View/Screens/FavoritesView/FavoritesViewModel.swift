//
//  FavoritesViewModel.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 22.07.2024.
//

import Foundation
import SwiftUI

extension FavoritesView {
    final class FavoritesViewModel: ObservableObject {
        @Published var favorites: [Follower] = []
        @Published var isShowingUserInfoView: Bool = false
        @Published var isEmptyState = false
        @Published var alertItem: AlertItem?
        
        @MainActor
        func getFavorites() {
            PersistenceManager.retrieveFavorites { result in
                switch result {
                case .success(let favorites):
                    self.favorites = favorites
                    self.checkIsEpmty()
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.alertItem = AlertItem(title: AlertItemConstants.failureTitle,
                                                   message: Text(error.rawValue),
                                                   dismissButton: .default(AlertItemConstants.dismissButtonTitle))
                    }
                }
            }
        }
        
        @MainActor
        func removeFromFavorites(favorite: Follower) {
            PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { error in
                guard let error = error else {
                    print("\(favorite.login) is removed")
                    self.favorites.removeAll { $0 == favorite }
                    self.checkIsEpmty()
                    return
                }
                DispatchQueue.main.async {
                    self.alertItem = AlertItem(title: AlertItemConstants.removeFromFavoritesTitle,
                                               message: Text(error.rawValue),
                                               dismissButton: .default(AlertItemConstants.dismissButtonTitle))
                }
            }
        }
        
        @MainActor
        func checkIsEpmty() {
            if favorites.isEmpty {
                DispatchQueue.main.async { self.showEmptyStateView() }
            } else {
                DispatchQueue.main.async { self.hideEmptyStateView() }
            }
        }
        
        @MainActor
        func showEmptyStateView() { isEmptyState = true }
        @MainActor
        func hideEmptyStateView() { isEmptyState = false }
    }
}
