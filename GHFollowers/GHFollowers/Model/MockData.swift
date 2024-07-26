//
//  MockData.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 22.07.2024.
//

import Foundation

struct MockData {
    static var user: User {
        let user = User(login: "Mock Login",
                        avatarUrl: "Mock Avatar",
                        publicRepos: 99,
                        publicGists: 99,
                        htmlUrl: "Mock Url",
                        following: 99,
                        followers: 99,
                        createdAt: Date.now)
        
        return user
    }
    
    static var follower: Follower {
        let follower = Follower(login: "Mock Login",
                                avatarUrl: "Mock Avatar")
        
        return follower
    }
}
