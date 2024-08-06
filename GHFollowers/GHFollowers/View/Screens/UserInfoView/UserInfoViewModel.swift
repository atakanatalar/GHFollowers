//
//  UserInfoViewModel.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 22.07.2024.
//

import Foundation
import SwiftUI

extension UserInfoView {
    class UserInfoViewModel: ObservableObject {
        @Published var selectedUsername: String
        @Published var user: User = MockData.user
        @Published var isLoading: Bool = false
        
        let addFavoriteTip = AddFavoriteTip()
        
        init (selectedUsername: String) {
            self.selectedUsername = selectedUsername
        }
        
        @MainActor
        func getUserInfo(username: String) async {
            showLoadingView()
            do {
                let user: User = try await NetworkManager.shared.fetchData(endpoint: Endpoint.userInfo(username: username))
                self.user = user
                hideLoadingView()
            } catch {
                if let gfError = error as? GFError {
                    DispatchQueue.main.async { Toast.shared.present(title: gfError.localizedDescription, symbol: ToastConstants.defaultErrorImageTitle, tint: Color(.systemRed)) }
                } else {
                    DispatchQueue.main.async { Toast.shared.present(title: ToastConstants.networkErrorMessage, symbol: ToastConstants.networkErrorImageTitle, tint: Color(.systemRed)) }
                }
            }
        }
        
        @MainActor
        func addUserToFavorite(user: User) {
            let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
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
    }
}
