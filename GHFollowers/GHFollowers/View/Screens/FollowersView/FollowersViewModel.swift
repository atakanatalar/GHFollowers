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
        @Published var isShowingProfileView: Bool = false
        
        let goToProfileTip = GoToProfileTip()
        
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
                let followers: [Follower] = try await NetworkManager.shared.fetchData(endpoint: Endpoint.followers(username: username, page: page))
                if followers.count < 100 { hasMoreFollower = false }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    DispatchQueue.main.async { self.showEmptyStateView() }
                }
            } catch {
                if let gfError = error as? GFError {
                    Toast.shared.present(title: gfError.localizedDescription, symbol: ToastConstants.defaultErrorImageTitle, tint: Color(.systemRed))
                } else {
                    Toast.shared.present(title: ToastConstants.networkErrorMessage, symbol: ToastConstants.networkErrorImageTitle, tint: Color(.systemRed))
                }
                showInvalidResponseView()
            }
            hideLoadingView()
        }
        
        @MainActor
        func addUserToFavorite(favorite: Follower) {
            let favorite = Follower(login: favorite.login, avatarUrl: favorite.avatarUrl)
            PersistenceManager.updateWith(favorite: favorite, actionType: .add) { error in
                guard error != nil else {
                    DispatchQueue.main.async {
                        Toast.shared.present(title: ToastConstants.addUserSuccessMessage, symbol: ToastConstants.addUserSuccessImageTitle, tint: Color(.systemGreen), timing: .medium)
                        HapticManager.playSuccess()
                    }
                    return
                }
                DispatchQueue.main.async {
                    Toast.shared.present(title: error?.localizedDescription ?? "", symbol: ToastConstants.addUserFailureImageTitle, tint: Color(.systemRed), timing: .medium)
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
        @ViewBuilder func createUserInfoView(selectedUsername: String, dynamicTypeSize: DynamicTypeSize) -> some View {
            if Device.isSmallScreen() {
                UserInfoView(viewModel: UserInfoView.UserInfoViewModel(selectedUsername: selectedUsername)).embedInScrollView()
            } else if dynamicTypeSize >= .accessibility1 {
                UserInfoView(viewModel: UserInfoView.UserInfoViewModel(selectedUsername: selectedUsername)).embedInScrollView()
            } else {
                UserInfoView(viewModel: UserInfoView.UserInfoViewModel(selectedUsername: selectedUsername))
            }
        }
    }
}
