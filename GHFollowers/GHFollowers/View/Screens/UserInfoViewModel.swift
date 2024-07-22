//
//  UserInfoViewModel.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 22.07.2024.
//

import Foundation
import SwiftUI

extension UserInfoView {
    final class UserInfoViewModel: ObservableObject {
        @Published var user: User = MockData.user
        @Published var isLoading: Bool = false
        @Published var alertItem: AlertItem?
        
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
                    alertItem = AlertItem(title: AlertItemConstants.failureTitle,
                                          message: Text(gfError.rawValue),
                                          dismissButton: .default(AlertItemConstants.dismissButtonTitle))
                } else {
                    alertItem = AlertContext.defaultError
                }
            }
        }
        
        @MainActor
        func showLoadingView() { isLoading = true }
        @MainActor
        func hideLoadingView() { isLoading = false }
    }
}