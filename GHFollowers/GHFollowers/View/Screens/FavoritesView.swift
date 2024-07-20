//
//  FavoritesView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 13.07.2024.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var userManager: UserManager
    
    @State var favorites: [Follower] = []
    @State var isShowingUserInfoView: Bool = false
    @State var isEmptyState = false
    @State var alertItem: AlertItem?
    
    var body: some View {
        ZStack {
            NavigationStack {
                List(favorites, id: \.self) { favorite in
                    FavoritesListCell(favorite: favorite)
                        .onTapGesture {
                            userManager.addUsername(to: favorite.login)
                            isShowingUserInfoView = true
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                removeFromFavorites(favorite: favorite)
                                self.favorites.removeAll { $0 == favorite }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
                .listStyle(.plain)
                .navigationTitle("Favorites")
            }
            if isEmptyState { EmptyStateView(message: "No Favorites?\nAdd one on the Followers screen ").padding(.horizontal, 40) }
        }
        .onAppear {
            getFavorites()
        }
        .sheet(isPresented: $isShowingUserInfoView) {
            NavigationStack {
                UserInfoView()
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Done") {
                                isShowingUserInfoView = false
                            }
                        }
                    }
            }
        }
    }
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                self.favorites = favorites
                if self.favorites.isEmpty {
                    DispatchQueue.main.async { showEmptyStateView() }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    alertItem = AlertItem(title: Text("Bad Stuff Happend"),
                                          message: Text(error.rawValue),
                                          dismissButton: .default(Text("Ok")))
                }
            }
        }
    }
    
    func removeFromFavorites(favorite: Follower) {
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { error in
            guard let error = error else {
                print("\(favorite.login) is removed")
                return
            }
            DispatchQueue.main.async {
                alertItem = AlertItem(title: Text("Unable to Remove"),
                                      message: Text(error.rawValue),
                                      dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    private func showEmptyStateView() { isEmptyState = true }
}

#Preview {
    FavoritesView()
}
