//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 15.07.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func fetchData<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw GFError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }
}

enum Endpoint {
    case followers(username: String, page: Int)
    case userInfo(username: String)
    
    var urlString: String {
        let baseUrl = "https://api.github.com/users/"
        
        switch self {
        case .followers(let username, let page):
            return "\(baseUrl)\(username)/followers?per_page=100&page=\(page)"
        case .userInfo(let username):
            return "\(baseUrl)\(username)"
        }
    }
    
    var url: URL? {
        return URL(string: self.urlString)
    }
}
