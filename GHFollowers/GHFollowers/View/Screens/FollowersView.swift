//
//  FollowersView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 15.07.2024.
//

import SwiftUI

struct FollowersView: View {
    @State var followers: [Follower] = []
    @State var alertItem: AlertItem?
    
    var username: String
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView{
                    LazyVGrid(columns: columns) {
                        ForEach(followers, id: \.self) { follower in
                            FollowersTitleView(follower: follower)
                        }
                    }
                    .padding()
                }
            }
            
        }
        .navigationTitle(username)
        .navigationBarTitleDisplayMode(.large)
        .task { await getFollowers() }
        .alert(item: $alertItem, content: { $0.alert })
    }
    
    private func getFollowers() async {
        do {
            followers = try await NetworkManager.shared.fetchFollowers(username: username, page: 1)
        } catch {
            if let gfError = error as? GFError {
                alertItem = AlertItem(title: Text("Bad Stuff Happend"), message: Text(gfError.rawValue), dismissButton: .default(Text("Ok")))
            } else {
                alertItem = AlertContext.defaultError
            }
        }
    }
}

#Preview {
    FollowersView(username: "username")
}
