//
//  FollowersViewModel.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 22.07.2024.
//

import Foundation
import SwiftUI

extension FollowersView {
    class FollowersViewModel: ObservableObject {
        @Published var followers: [Follower] = []
        @Published var page: Int = 1
        @Published var searchTerm: String = ""
        @Published var navigationTitle: String = ""
        @Published var hasMoreFollower: Bool = true
        @Published var isLoading: Bool = false
        @Published var isEmptyState: Bool = false
        @Published var isInvalidResponse: Bool = false
        @Published var isShowingUserInfoView: Bool = false
        @Published var selectedUsername: String
        
        var filteredFollowers: [Follower] {
            guard !searchTerm.isEmpty else { return followers }
            return followers.filter { $0.login.localizedCaseInsensitiveContains(searchTerm) }
        }
        
        init(selectedUsername: String) {
            self.selectedUsername = selectedUsername
        }
        
        @MainActor
        func getColumns(dynamicTypeSize: DynamicTypeSize) -> [GridItem] {
            return Array(repeating: GridItem(.flexible()), count: dynamicTypeSize >= .accessibility1 ? 2 : 3)
        }
        
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
            } catch {
                if let gfError = error as? GFError {
                    Toast.shared.present(title: gfError.rawValue, symbol: ToastConstants.networkErrorImageTitle, tint: Color(.systemRed))
                    showInvalidResponseView()
                } else {
                    Toast.shared.present(title: ToastConstants.defaultErrorMessage, symbol: ToastConstants.defaultErrorImageTitle, tint: Color(.systemRed))
                }
            }
            hideLoadingView()
        }
        
        @MainActor
        func addUserToFavorite(user: User) {
            let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
            PersistenceManager.updateWith(favorite: favorite, actionType: .add) { error in
                guard error != nil else {
                    DispatchQueue.main.async {
                        Toast.shared.present(title: ToastConstants.addUserSuccessMessage, symbol: ToastConstants.addUserSuccessImageTitle, tint: Color(.systemGreen), timing: .medium)
                    }
                    return
                }
                DispatchQueue.main.async {
                    Toast.shared.present(title: error?.rawValue ?? "", symbol: ToastConstants.addUserFailureImageTitle, tint: Color(.systemRed), timing: .medium)
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
                            Toast.shared.present(title: gfError.rawValue, symbol: ToastConstants.networkErrorImageTitle, tint: Color(.systemRed))
                        }
                    } else {
                        DispatchQueue.main.async {
                            Toast.shared.present(title: ToastConstants.defaultErrorMessage, symbol: ToastConstants.defaultErrorImageTitle, tint: Color(.systemRed))
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
        func showInvalidResponseView() { isInvalidResponse = true }
        
        @MainActor
        @ViewBuilder func createUserInfoView(selectedFollower: Follower, dynamicTypeSize: DynamicTypeSize) -> some View {
            if dynamicTypeSize >= .accessibility1 {
                UserInfoView(viewModel: UserInfoView.UserInfoViewModel(selectedFollower: selectedFollower)).embedInScrollView()
            } else {
                UserInfoView(viewModel: UserInfoView.UserInfoViewModel(selectedFollower: selectedFollower))
            }
        }
    }
}
