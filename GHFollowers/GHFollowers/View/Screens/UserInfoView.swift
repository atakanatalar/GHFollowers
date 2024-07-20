//
//  UserInfoView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 17.07.2024.
//

import SwiftUI

struct UserInfoView: View {
    @EnvironmentObject var userManager: UserManager
    @Environment(\.dismiss) var dismiss
    
    @State var user: User?
    @State var isLoading: Bool = false
    @State var alertItem: AlertItem?
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack() {
                    HStack {
                        UserInfoHeaderView(user: user ?? User(login: "", avatarUrl: "", publicRepos: 0, publicGists: 0, htmlUrl: "", following: 0, followers: 0, createdAt: Date.now))
                        Spacer()
                    }
                    
                    RepoItemInfoView(user: user ?? User(login: "", avatarUrl: "", publicRepos: 0, publicGists: 0, htmlUrl: "", following: 0, followers: 0, createdAt: Date.now))
                    FollowerItemInfoView(user: user ?? User(login: "", avatarUrl: "", publicRepos: 0, publicGists: 0, htmlUrl: "", following: 0, followers: 0, createdAt: Date.now))
                    
                    Spacer()
                    
                    if let user {
                        Label("GitHub since \(user.createdAt.convertToMonthYearFormat())", systemImage: "calendar")
                            .padding()
                    }
                }
                .padding(.horizontal)
            }
            if isLoading { LoadingView() }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task { await getUserInfo(username: userManager.usernames.last ?? "username") }
        .alert(item: $alertItem, content: { $0.alert })
        .onAppear {
            print(userManager.usernames)
        }
        .onDisappear {
            userManager.removeUsername()
        }
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
                alertItem = AlertItem(title: Text("Bad Stuff Happend"),
                                      message: Text(gfError.rawValue),
                                      dismissButton: .default(Text("Ok")))
            } else {
                alertItem = AlertContext.defaultError
            }
        }
    }
    
    private func showLoadingView() { isLoading = true }
    private func hideLoadingView() { isLoading = false }
}

#Preview {
    UserInfoView()
}
