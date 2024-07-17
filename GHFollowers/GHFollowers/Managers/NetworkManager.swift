//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 15.07.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchFollowers(username: String, page: Int) async throws -> [Follower] {
        let urlString = "\(baseUrl)\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: urlString) else {
            throw GFError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        
        do {
            return try decoder.decode([Follower].self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }
    
    func fetchUserInfo(username: String) async throws -> User  {
        let urlString = "\(baseUrl)\(username)"
        
        guard let url = URL(string: urlString) else {
            throw GFError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }
}
