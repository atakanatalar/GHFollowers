//
//  Constants.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 21.07.2024.
//

import Foundation
import SwiftUI

enum SearchViewConstants {
    static let textFieldText = "Enter a username"
    static let buttonTitle = "Get Followers"
    static let buttonImageTitle = "person.3"
}

enum FollowersViewConstants {
    static let followersTitleViewTitle = "More Followers"
    static let followersTitleViewAvatarUrl = ""
    static let searchTitle = "Search Followers"
    static let emptyMessage = "This user doesn't have any followers, go follow them"
    static let userInfoViewToolbarButtonTitle = "Done"
    static let noResultMessageFirst = "No result for \""
    static let noResultMessageSecond = "\" "
    static let favoriteToolbarButtonTitle = "Favorite"
    static let favoriteToolbarButtonImageTitle = "star"
}

enum AlertItemConstants {
    static let successTitle = Text("Success")
    static let failureTitle = Text("Bad Stuff Happend")
    static let dismissButtonTitle = Text("Ok")
    static let addUserSuccessMessage = Text("You have successfully favorited this user")
    static let errorMessage = "We were unable to complete your task at this time. Please try again"
}

enum KeyboardConstants {
    static let imageTitle = "keyboard.chevron.compact.down"
}
