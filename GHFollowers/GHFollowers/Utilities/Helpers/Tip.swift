//
//  Tip.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 28.07.2024.
//

import SwiftUI
import TipKit

struct AddFavoriteTip: Tip {
    static let viewVisitedEvent = Event(id: "viewVisited")
    
    var title: Text { TipConstants.addToFavoriteTitle }
    
    var message: Text? { TipConstants.addToFavoriteTitleMessage }
    
    var rules: [Rule] {
        #Rule(Self.viewVisitedEvent) { event in
            event.donations.count < 3
        }
    }
}
