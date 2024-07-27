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
        @Published var selectedFollower: Follower
        @Published var user: User = MockData.user
        @Published var isLoading: Bool = false
        
        init (selectedFollower: Follower) {
            self.selectedFollower = selectedFollower
        }
        
        @MainActor
        func getUserInfo(username: String) async {
            showLoadingView()
            do {
                let user = try await NetworkManager.shared.fetchUserInfo(username: username)
                self.user = user
                hideLoadingView()
            } catch {
                hideLoadingView()
                if let gfError = error as? GFError {
                    DispatchQueue.main.async { Toast.shared.present(title: gfError.rawValue, symbol: ToastConstants.networkErrorImageTitle, tint: Color(.systemRed)) }
                } else {
                    DispatchQueue.main.async { Toast.shared.present(title: ToastConstants.defaultErrorMessage, symbol: ToastConstants.defaultErrorImageTitle, tint: Color(.systemRed)) }
                }
            }
        }
        
        @MainActor
        func showLoadingView() { isLoading = true }
        @MainActor
        func hideLoadingView() { isLoading = false }
    }
}
