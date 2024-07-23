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

enum UserInfoViewConstants {
    static let dateLabelTitle = "GitHub since"
    static let dateLabelImageTitle = "calendar"
}

enum FavoritesViewConstants {
    static let swipeDeleteButtonTitle = "Delete"
    static let swipeDeleteButtonImageTitle = "trash"
    static let navigationTitle = "Favorites"
    static let emptyMessage = "No Favorites?\nAdd one on the Followers screen"
    static let userInfoViewToolbarButtonTitle = "Done"
}

enum OnboardViewConstants {
    static let viewFollowersImageTitle = "person"
    static let viewFollowersTitle = "View Followers"
    static let viewFollowersDescription = "See the followers of a given GitHub username and explore their list of followers"
    static let profileViewingImageTitle = "person.crop.square.filled.and.at.rectangle"
    static let profileViewingTitle = "Profile Viewing"
    static let profileViewingDescription = "Click on followers' profiles to view detailed information"
    static let favoritesListImageTitle = "list.star"
    static let favoritesListTitle = "Favorites List"
    static let favoritesListDescription = "Add desired users to your favorites list for easy access"
    static let buttonTitle = "Contiune"
    static let buttonImageTitle = "arrow.right"
}

enum AppTabViewConstants {
    static let searchViewTabItemTitle = "Search"
    static let searchViewTabItemImageTitle = "magnifyingglass"
    static let favoritesViewTabItemTitle = "Favorites"
    static let favoritesViewTabItemImageTitle = "star"
}

enum RepoItemInfoViewConstants {
    static let gitHubProfileButtonTitle = "GitHub Profile"
    static let gitHubProfileButtonImageTitle = "person"
}

enum FollowersItemInfoViewConstants {
    static let getFollowersButtonTitle = "Get Followers"
    static let getFollowersButtonImageTitle = "person.3"
}

enum ItemInfoViewConstants {
    static let publicReposTitle = "Public Repos"
    static let publicReposImageTitle = "folder"
    static let publicGistsTitle = "Public Gists"
    static let publicGistsImageTitle = "text.alignleft"
    static let followersTitle = "Followers"
    static let followersImageTitle = "heart"
    static let followingTitle = "Following"
    static let followingImageTitle = "person.2"
}

enum AlertItemConstants {
    static let successTitle = Text("Success")
    static let failureTitle = Text("Bad Stuff Happend")
    static let removeFromFavoritesTitle = Text("Unable to Remove")
    static let invalidUsernameTitle = Text("Empty Username")
    static let defaultErrorTitle = Text("Something Went Wrong")
    static let dismissButtonTitle = Text("Ok")
    static let addUserSuccessMessage = Text("You have successfully favorited this user")
    static let errorMessage = "We were unable to complete your task at this time. Please try again"
    static let invalidUsernameMessage = Text("Please enter a username, we need to know who to look for")
    static let defaultErrorMessage = Text("We were unable to complete your task at this time. Please try again")
}

enum KeyboardConstants {
    static let imageTitle = "keyboard.chevron.compact.down"
}
