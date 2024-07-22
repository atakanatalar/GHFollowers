//
//  AppTabView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 13.07.2024.
//

import SwiftUI

struct AppTabView: View {
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    @State var isShowingOnboardView: Bool = false
    
    var body: some View {
        TabView {
            SearchView()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
            
            FavoritesView()
                .tabItem { Label("Favorites", systemImage: "star") }
        }
        .onAppear {
            if isFirstTime {
                DispatchQueue.main.async() {
                    isShowingOnboardView = true
                }
            }
        }
        .sheet(isPresented: $isShowingOnboardView) {
            OnboardView(isShowingOnboardView: $isShowingOnboardView)
                .interactiveDismissDisabled()
        }
    }
}

#Preview {
    AppTabView()
}
