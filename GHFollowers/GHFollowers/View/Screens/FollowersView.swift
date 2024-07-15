//
//  FollowersView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 15.07.2024.
//

import SwiftUI

struct FollowersView: View {
    var username: String
    @State var followers: [Follower] = []
    @State var alertItem: AlertItem?
    
    var body: some View {
        ZStack {
            Text("Followers View")
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
