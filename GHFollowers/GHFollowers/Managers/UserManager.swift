//
//  UserManager.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 19.07.2024.
//

import Foundation

class UserManager: ObservableObject {
    @Published var usernames: [String] = []
    
    func addUsername(to username: String) {
        usernames.append(username)
    }
    
    func removeUsername() {
        if !usernames.isEmpty { usernames.removeLast() }
    }
}
