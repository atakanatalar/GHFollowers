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
    static let viewVisitedEvent = Event(id: "viewVisited")
    
    var id = UUID()
    var title: Text { TipConstants.addToFavoriteTitle }
    var message: Text? { TipConstants.addToFavoriteTitleMessage }
    
    @available(iOS 17.0, *)
    var rules: [Rule] {
        #Rule(Self.viewVisitedEvent) { event in
            event.donations.count < 3
        }
    }
}
