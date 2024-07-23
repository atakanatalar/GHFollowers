//
//  FollowersViewModel.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 22.07.2024.
//

import Foundation
import SwiftUI

extension FollowersView {
    final class FollowersViewModel: ObservableObject {
        @Published var followers: [Follower] = []
        @Published var page: Int = 1
        @Published var searchTerm: String = ""
        @Published var navigationTitle: String = ""
        @Published var hasMoreFollower: Bool = true
        @Published var isLoading: Bool = false
        @Published var isEmptyState: Bool = false
        @Published var alertItem: AlertItem?
        @Published var isShowingUserInfoView: Bool = false
        
        var filteredFollowers: [Follower] {
            guard !searchTerm.isEmpty else { return followers }
            return followers.filter { $0.login.localizedCaseInsensitiveContains(searchTerm) }
        }
        let columns = Array(repeating: GridItem(.flexible()), count: 3)
        
        @MainActor
        func getFollowers(username: String, page: Int) async {
            showLoadingView()
            do {
                let followers = try await NetworkManager.shared.fetchFollowers(username: username, page: page)
                if followers.count < 100 { hasMoreFollower = false }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    DispatchQueue.main.async { self.showEmptyStateView() }
                }
                hideLoadingView()
            } catch {
                hideLoadingView()
                if let gfError = error as? GFError {
                    alertItem = AlertItem(title: AlertItemConstants.failureTitle,
                                          message: Text(gfError.rawValue),
                                          dismissButton: .default(AlertItemConstants.dismissButtonTitle))
                } else {
                    alertItem = AlertContext.defaultError
                }
            }
        }
        
        @MainActor
        func addUserToFavorite(user: User) {
            let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
            PersistenceManager.updateWith(favorite: favorite, actionType: .add) { error in
                guard error != nil else {
                    DispatchQueue.main.async { self.alertItem = AlertContext.addUserSuccess }
                    return
                }
                DispatchQueue.main.async {
                    self.alertItem = AlertItem(title: AlertItemConstants.failureTitle,
                                               message: Text(error?.rawValue ?? AlertItemConstants.errorMessage),
                                               dismissButton: .default(AlertItemConstants.dismissButtonTitle))
                }
            }
        }
        
        @MainActor
        func getUserForFavorite(username: String) {
            showLoadingView()
            Task {
                do {
                    let user = try await NetworkManager.shared.fetchUserInfo(username: username)
                    addUserToFavorite(user: user)
                    hideLoadingView()
                } catch {
                    if let gfError = error as? GFError {
                        DispatchQueue.main.async {
                            self.alertItem = AlertItem(title: AlertItemConstants.failureTitle,
                                                       message: Text(gfError.rawValue),
                                                       dismissButton: .default(AlertItemConstants.dismissButtonTitle))
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.alertItem = AlertContext.defaultError
                        }
                    }
                    hideLoadingView()
                }
            }
        }
        
        @MainActor
        func showLoadingView() { isLoading = true }
        @MainActor
        func hideLoadingView() { isLoading = false }
        @MainActor
        func showEmptyStateView() { isEmptyState = true }
        
        @MainActor
        @ViewBuilder func createUserInfoView() -> some View {
            UserInfoView()
        }
    }
}
