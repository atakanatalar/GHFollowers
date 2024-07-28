//
//  GHFollowersApp.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 13.07.2024.
//

import SwiftUI
import TipKit

@main
struct GHFollowersApp: App {
    var body: some Scene {
        WindowGroup {
            RootView {
                ContentView()
                    .task {
                        try? Tips.configure([
                            .datastoreLocation(.applicationDefault)])
                    }
            }
        }
    }
}
