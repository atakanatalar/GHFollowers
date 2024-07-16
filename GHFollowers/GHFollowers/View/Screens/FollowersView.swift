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
    @State var username: String
    @State var page: Int = 1
    @State var hasMoreFollower: Bool = true
    @State var isLoading = false
    
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView{
                    LazyVGrid(columns: columns) {
                        ForEach(followers, id: \.self) { follower in
                            FollowersTitleView(follower: follower)
                        }
                        
                        if hasMoreFollower {
//                            LoadingView()
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
                }
            }
            if isLoading { LoadingView() }
        }
        .navigationTitle(username)
        .navigationBarTitleDisplayMode(.large)
        .task { await getFollowers(username: username, page: page) }
        .alert(item: $alertItem, content: { $0.alert })
    }
    
    private func getFollowers(username: String, page: Int) async {
        showLoadingView()
        do {
            let followers = try await NetworkManager.shared.fetchFollowers(username: username, page: page)
            if followers.count < 100 { hasMoreFollower = false }
            self.followers.append(contentsOf: followers)
            hideLoadingView()
        } catch {
            hideLoadingView()
            if let gfError = error as? GFError {
                alertItem = AlertItem(title: Text("Bad Stuff Happend"), message: Text(gfError.rawValue), dismissButton: .default(Text("Ok")))
            } else {
                alertItem = AlertContext.defaultError
            }
        }
//        hideLoadingView()
    }
    
    private func showLoadingView() { isLoading = true }
    private func hideLoadingView() { isLoading = false }
}

#Preview {
    FollowersView(username: "username")
}
