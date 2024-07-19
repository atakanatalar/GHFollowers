//
//  FollowersView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 15.07.2024.
//

import SwiftUI

struct FollowersView: View {
    @State var alertItem: AlertItem?
    @State var followers: [Follower] = []
    @State var selectedUsername: String = ""
    @State var username: String
    @State var page: Int = 1
    @State var hasMoreFollower: Bool = true
    @State var isLoading = false
    @State var isEmptyState = false
    @State var searchTerm = ""
    @State var isShowingUserInfoView: Bool = false
    
    var filteredFollowers: [Follower] {
        guard !searchTerm.isEmpty else { return followers }
        return followers.filter { $0.login.localizedCaseInsensitiveContains(searchTerm) }
    }
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(filteredFollowers, id: \.self) { follower in
                            FollowersTitleView(follower: follower)
                                .onTapGesture {
                                    selectedUsername = follower.login
                                    isShowingUserInfoView = true
                                }
                        }
                        
                        if hasMoreFollower && !self.followers.isEmpty {
                            FollowersTitleView(follower: Follower(login: "More Followers", avatarUrl: ""))
                                .onAppear {
                                    Task {
                                        page += 1
                                        await getFollowers(username: username, page: page)
                                    }
                                }
                        }
                    }
                    .padding()
                    .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Followers")
                }
            }
            if isEmptyState { EmptyStateView(message: "This user doesn't have any followers, go follow them").padding(.horizontal, 40) }
            if isLoading { LoadingView() }
        }
        .navigationTitle(username)
        .navigationBarTitleDisplayMode(.large)
        .task { await getFollowers(username: username, page: page) }
        .sheet(isPresented: $isShowingUserInfoView) {
            NavigationStack {
                UserInfoView(username: selectedUsername)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Done") {
                                isShowingUserInfoView = false
                            }
                        }
                    }
            }
        }
        .alert(item: $alertItem, content: { $0.alert })
        .overlay {
            if filteredFollowers.isEmpty && !followers.isEmpty {
                EmptyStateView(message: "No result for \"\(searchTerm)\" ").padding(.horizontal, 40)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button() {
                    showLoadingView()
                    
                    Task {
                        do {
                            let user = try await NetworkManager.shared.fetchUserInfo(username: username)
                            addUserToFavorite(user: user)
                            hideLoadingView()
                        } catch {
                            if let gfError = error as? GFError {
                                alertItem = AlertItem(title: Text("Bad Stuff Happend"),
                                                      message: Text(gfError.rawValue),
                                                      dismissButton: .default(Text("Ok")))
                            } else {
                                alertItem = AlertContext.defaultError
                            }
                            hideLoadingView()
                        }
                    }
                } label: {
                    Label("", systemImage: "star")
                }
            }
        }
    }
    
    private func getFollowers(username: String, page: Int) async {
        showLoadingView()
        do {
            let followers = try await NetworkManager.shared.fetchFollowers(username: username, page: page)
            if followers.count < 100 { hasMoreFollower = false }
            self.followers.append(contentsOf: followers)
            if self.followers.isEmpty {
                DispatchQueue.main.async { showEmptyStateView() }
            }
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
    
    func addUserToFavorite(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { error in
            guard error != nil else {
                DispatchQueue.main.async {
                    alertItem = AlertItem(title: Text("Success"),
                                          message: Text("You have successfully favorited this user"),
                                          dismissButton: .default(Text("Ok")))
                }
                return
            }
            DispatchQueue.main.async {
                alertItem = AlertItem(title: Text("Something went wrong"),
                                      message: Text(error?.rawValue ?? "We were unable to complete your task at this time. Please try again"),
                                      dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    private func showLoadingView() { isLoading = true }
    private func hideLoadingView() { isLoading = false }
    private func showEmptyStateView() { isEmptyState = true }
}

#Preview {
    FollowersView(username: "username")
}
