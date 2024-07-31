//
//  Constants.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 21.07.2024.
//

import Foundation
import SwiftUI

enum SearchViewConstants {
    static let textFieldText = String.localized("search_text_field_text")
    static let buttonTitle = String.localized("search_button_title")
    static let buttonImageTitle = "person.3"
    static let accessibilityLabelAppLogo = String.localized("search_accessibility_label_app_logo")
    static let accessibilityHintButton = String.localized("search_accessibility_hint_button")
}

enum FollowersViewConstants {
    static let followersTitleViewTitle = String.localized("followers_title_view_title")
    static let followersTitleViewAvatarUrl = ""
    static let searchTitle = String.localized("followers_search_title")
    static let emptyMessage = String.localized("followers_empty_message")
    static let contextMenuFavoriteButtonTitle = String.localized("followers_context_menu_favorite_button_title")
    static let contextMenuFavoriteButtonImageTitle = "star"
    static let invalidResponseMessage = String.localized("followers_invalid_response_message")
    static let noResultMessageFirst = String.localized("followers_no_result_message1")
    static let noResultMessageSecond = String.localized("followers_no_result_message2")
    static let profileButtonImageTitle = "person"
    static let accessibilityHintTitleView = String.localized("followers_accessibility_hint_title_view")
    static let accessibilityLabelProfileButton = String.localized("followers_accessibility_label_profile_button")
    static let accessibilityHintProfileButton = String.localized("followers_accessibility_hint_profile_button")
}

enum UserInfoViewConstants {
    static let dateLabelImageTitle = "calendar"
    static let favoriteToolbarButtonImageTitle = "plus"
    static let accessibilityHintCreatedAt = String.localized("user_info_accessibility_hint_created_at")
    static let accessibilityLabelFavoriteButton = String.localized("user_info_accessibility_label_favorite_button")
    static let accessibilityHintFavoriteButton = String.localized("user_info_accessibility_hint_favorite_button")
}

enum FavoritesViewConstants {
    static let swipeDeleteButtonTitle = String.localized("favorites_swipe_button_title")
    static let swipeDeleteButtonImageTitle = "trash"
    static let navigationTitle = String.localized("favorites_navigation_title")
    static let emptyMessage = String.localized("favorites_empty_message")
    static let accessibilityHintListCell = String.localized("favorites_accessibility_hint_list_cell")
}

enum OnboardViewConstants {
    static let viewFollowersImageTitle = "person"
    static let viewFollowersTitle = String.localized("onboard_title1")
    static let viewFollowersDescription = String.localized("onboard_description1")
    static let profileViewingImageTitle = "person.crop.square.filled.and.at.rectangle"
    static let profileViewingTitle = String.localized("onboard_title2")
    static let profileViewingDescription = String.localized("onboard_description2")
    static let favoritesListImageTitle = "list.star"
    static let favoritesListTitle = String.localized("onboard_title3")
    static let favoritesListDescription = String.localized("onboard_description3")
    static let buttonTitle = String.localized("onboard_button_title" )
    static let buttonImageTitle = "arrow.right"
    static let accessibilityLabelAppLogo = String.localized("onboard_accessibility_label_app_logo")
    static let accessibilityHintButton = String.localized("onboard_accessibility_hint_button")
}

enum AppTabViewConstants {
    static let searchViewTabItemTitle = String.localized("app_tab_search_tab_item_title")
    static let searchViewTabItemImageTitle = "magnifyingglass"
    static let favoritesViewTabItemTitle = String.localized("app_tab_favorites_tab_item_title")
    static let favoritesViewTabItemImageTitle = "star"
}

enum UserInfoHeaderViewConstants {
    static let accessibilityLabelAvatarView = String.localized("user_info_header_accessibility_label_avatar_view")
}

enum RepoItemInfoViewConstants {
    static let gitHubProfileButtonTitle = String.localized("repo_item_button")
    static let gitHubProfileButtonImageTitle = "person"
    static let accessibilityHintGitHub = String.localized("repo_item_accessibility_hint_gitHub")
}

enum FollowersItemInfoViewConstants {
    static let getFollowersButtonTitle = String.localized("followers_item_button")
    static let getFollowersButtonImageTitle = "person.3"
    static let accessibilityHintFollowers = String.localized("followers_item_accessibility_hint_followers")
}

enum ItemInfoViewConstants {
    static let publicReposTitle = String.localized("item_info_repos_title")
    static let publicReposImageTitle = "folder"
    static let publicGistsTitle = String.localized("item_info_gists_title")
    static let publicGistsImageTitle = "text.alignleft"
    static let followersTitle = String.localized("item_info_followers_title")
    static let followersImageTitle = "heart"
    static let followingTitle = String.localized("item_info_following_title")
    static let followingImageTitle = "person.2"
}

enum ToastConstants {
    static let addUserSuccessMessage = String.localized("toast_add_user_success_message")
    static let invalidUsernameMessage = String.localized("toast_invalid_username_message")
    static let networkErrorMessage = String.localized("toast_network_error_message")
    static let invalidUsernameImageTitle = "person.fill.questionmark"
    static let defaultErrorImageTitle = "exclamationmark.triangle"
    static let networkErrorImageTitle = "network.slash"
    static let addUserSuccessImageTitle = "person.fill.checkmark"
    static let addUserFailureImageTitle = "person.fill.xmark"
    static let removeSuccessImageTitle = "person.fill.xmark"
    static let removeSuccessMessage = String.localized("toast_remove_user_success_message" )
    
}

enum TipConstants {
    static let addToFavoriteTitle = Text(String.localized("tip_add_to_favorite_title"))
    static let addToFavoriteTitleMessage = Text(String.localized("tip_add_to_favorite_message"))
    static let seeUserInfoTitle = Text(String.localized("tip_see_user_info_title"))
    static let seeUserInfoTitleMessage = Text(String.localized("tip_see_user_info_message"))
}

enum SplashViewConstants {
    static let accessibilityLabelAppLogo = String.localized("splash_accessibility_label_app_logo")
}

enum KeyboardConstants {
    static let imageTitle = "keyboard.chevron.compact.down"
}
