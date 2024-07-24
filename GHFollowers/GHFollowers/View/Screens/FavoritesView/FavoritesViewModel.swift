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
        
        @MainActor
        func getFavorites() {
            PersistenceManager.retrieveFavorites { result in
                switch result {
                case .success(let favorites):
                    self.favorites = favorites
                    self.checkIsEpmty()
                case .failure(let error):
                    DispatchQueue.main.async {
                        Toast.shared.present(title: error.rawValue, symbol: ToastConstants.defaultErrorImageTitle, tint: Color(.systemRed))
                    }
                }
            }
        }
        
        @MainActor
        func removeFromFavorites(favorite: Follower) {
            PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { error in
                guard let error = error else {
                    let toastTitle = "\(favorite.login)" + ToastConstants.removeSuccessTitle
                    Toast.shared.present(title: toastTitle, symbol: ToastConstants.removeSuccessImageTitle, tint: Color(.systemGreen), timing: .medium)
                    self.favorites.removeAll { $0 == favorite }
                    self.checkIsEpmty()
                    return
                }
                DispatchQueue.main.async {
                    Toast.shared.present(title: error.rawValue, symbol: ToastConstants.defaultErrorImageTitle, tint: Color(.systemRed), timing: .medium)
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
