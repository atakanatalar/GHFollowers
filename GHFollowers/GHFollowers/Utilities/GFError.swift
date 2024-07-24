//
//  GFError.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 15.07.2024.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request, please try again"
    case invalidResponse = "Invalid response from the server, please try again"
    case invalidData = "The data received from the server was invalid, please try again"
    case unableToFavorite = "There was an error favoriting this user, Please try again"
    case alreadyInFavorites = "You have already favorited this user, you must really like them"
}
