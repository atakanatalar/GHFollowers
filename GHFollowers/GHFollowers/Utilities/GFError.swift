//
//  GFError.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 15.07.2024.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "error_invalid_username"
    case invalidResponse = "error_invalid_response"
    case invalidData = "error_invalid_data"
    case unableToFavorite = "error_unable_to_favorite"
    case alreadyInFavorites = "error_already_in_favorites"
    
    var localizedDescription: String {
        return String.localized(self.rawValue)
    }
}
