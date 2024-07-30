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
        @Published var profile: Follower = MockData.follower
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
                let followers = try await NetworkManager.shared.fetchFollowers(username: username, page: page)
                if followers.count < 100 { hasMoreFollower = false }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    DispatchQueue.main.async { self.showEmptyStateView() }
                }
            } catch {
                if let gfError = error as? GFError {
                    Toast.shared.present(title: gfError.localizedDescription, symbol: ToastConstants.defaultErrorImageTitle, tint: Color(.systemRed))
                    showInvalidResponseView()
                } else {
                    Toast.shared.present(title: ToastConstants.networkErrorMessage, symbol: ToastConstants.networkErrorImageTitle, tint: Color(.systemRed))
                }
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
        func getUserInfo(username: String) async {
            showLoadingView()
            do {
                let user = try await NetworkManager.shared.fetchUserInfo(username: username)
                let profile = Follower(login: user.login, avatarUrl: user.avatarUrl)
                self.profile = profile
            } catch {
                if let gfError = error as? GFError {
                    DispatchQueue.main.async { Toast.shared.present(title: gfError.localizedDescription, symbol: ToastConstants.defaultErrorImageTitle, tint: Color(.systemRed)) }
                } else {
                    DispatchQueue.main.async { Toast.shared.present(title: ToastConstants.networkErrorMessage, symbol: ToastConstants.networkErrorImageTitle, tint: Color(.systemRed)) }
                }
            }
            hideLoadingView()
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
            if Device.isSmallScreen() {
                UserInfoView(viewModel: UserInfoView.UserInfoViewModel(selectedFollower: selectedFollower)).embedInScrollView()
            } else if dynamicTypeSize >= .accessibility1 {
                UserInfoView(viewModel: UserInfoView.UserInfoViewModel(selectedFollower: selectedFollower)).embedInScrollView()
            } else {
                UserInfoView(viewModel: UserInfoView.UserInfoViewModel(selectedFollower: selectedFollower))
            }
        }
    }
}
