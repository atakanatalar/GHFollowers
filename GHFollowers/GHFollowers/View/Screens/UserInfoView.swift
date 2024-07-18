//
//  UserInfoView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 17.07.2024.
//

import SwiftUI

struct UserInfoView: View {
    @Environment(\.dismiss) var dismiss
    
    var username: String
    
    @State var user: User?
    @State var isLoading = false
    @State var alertItem: AlertItem?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    UserInfoHeaderView(user: user ?? User(login: "", avatarUrl: "", publicRepos: 0, publicGists: 0, htmlUrl: "", following: 0, followers: 0, createdAt: ""))
                    Spacer()
                }
                
                RepoItemInfoView(user: user ?? User(login: "", avatarUrl: "", publicRepos: 0, publicGists: 0, htmlUrl: "", following: 0, followers: 0, createdAt: ""))
                FollowerItemInfoView(user: user ?? User(login: "", avatarUrl: "", publicRepos: 0, publicGists: 0, htmlUrl: "", following: 0, followers: 0, createdAt: ""))
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .task { await getUserInfo(username: username) }
        .alert(item: $alertItem, content: { $0.alert })
    }
    
    private func getUserInfo(username: String) async {
        showLoadingView()
        do {
            let user = try await NetworkManager.shared.fetchUserInfo(username: username)
            self.user = user
            
            hideLoadingView()
        } catch {
            hideLoadingView()
            if let gfError = error as? GFError {
                alertItem = AlertItem(title: Text("Bad Stuff Happend"), message: Text(gfError.rawValue), dismissButton: .default(Text("Ok")))
            } else {
                alertItem = AlertContext.defaultError
            }
        }
    }
    
    private func showLoadingView() { isLoading = true }
    private func hideLoadingView() { isLoading = false }
}

#Preview {
    UserInfoView(username: "")
}
