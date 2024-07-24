//
//  SearchViewModel.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 21.07.2024.
//

import Foundation
import SwiftUI

extension SearchView {
    final class SearchViewModel: ObservableObject {
        @Published var username: String = ""
        @Published var isShowingFollowersView: Bool = false
        
        var isUsernameEmpty: Bool { return username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        
        @MainActor
        @ViewBuilder func createFollowersView() -> some View {
            FollowersView()
        }
    }
}
