//
//  MockData.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 22.07.2024.
//

import Foundation

struct MockData {
    static var user: User {
        let user = User(login: "login",
                        avatarUrl: "avatarUrl",
                        publicRepos: 99,
                        publicGists: 99,
                        htmlUrl: "htmlUrl",
                        following: 99,
                        followers: 99,
                        createdAt: Date.now)
        return user
    }
}
