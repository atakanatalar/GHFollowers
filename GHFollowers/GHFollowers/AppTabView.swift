//
//  AppTabView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 13.07.2024.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
            
            FavoritesView()
                .tabItem { Label("Favorites", systemImage: "star") }
        }
    }
}

#Preview {
    AppTabView()
}
