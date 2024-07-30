//
//  Tip.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 28.07.2024.
//

import SwiftUI
import TipKit

struct AddFavoriteTip: Identifiable, Tip {
    @available(iOS 17.0, *)
    static let userInfoViewVisitedEvent = Event(id: "userInfoViewVisitedEvent")
    
    var id = UUID()
    var title: Text { TipConstants.addToFavoriteTitle }
    var message: Text? { TipConstants.addToFavoriteTitleMessage }
    
    @available(iOS 17.0, *)
    var rules: [Rule] {
        #Rule(Self.userInfoViewVisitedEvent) { event in
            event.donations.count < 3
        }
    }
}

struct GoToProfileTip: Identifiable, Tip {
    @available(iOS 17.0, *)
    static let followersViewVisitedEventProfile = Event(id: "followersViewVisitedEve")
    
    var id = UUID()
    var title: Text { TipConstants.seeUserInfoTitle }
    var message: Text? { TipConstants.seeUserInfoTitleMessage }
    
    @available(iOS 17.0, *)
    var rules: [Rule] {
        #Rule(Self.followersViewVisitedEventProfile) { event in
            event.donations.count < 3
        }
    }
}
