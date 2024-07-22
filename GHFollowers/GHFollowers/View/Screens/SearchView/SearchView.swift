//
//  SearchView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 13.07.2024.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var userManager: UserManager
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                
                VStack {
                    LogoView(frameWidth: 200)
                        .padding(.top, 96)
                        .padding(.bottom, 24)
                    
                    TextField(SearchViewConstants.textFieldText, text: $viewModel.username)
                        .modifier(CustomTextFieldModifier())
                        .padding(.horizontal, 48)
                        .onSubmit {
                            if !viewModel.isUsernameEmpty {
                                userManager.addUsername(to: viewModel.username)
                                viewModel.isShowingFollowersView = true
                            } else {
                                viewModel.alertItem = AlertContext.invalidUsername
                            }
                        }
                    
                    Spacer()
                    
                    Button {
                        userManager.addUsername(to: viewModel.username)
                        viewModel.isShowingFollowersView = true
                    } label: {
                        Label(SearchViewConstants.buttonTitle, systemImage: SearchViewConstants.buttonImageTitle)
                            .frame(maxWidth: .infinity, maxHeight: 48)
                    }
                    .modifier(CustomButtonModifier(backgroundColor: Color(.systemGreen)))
                    .disabled(viewModel.isUsernameEmpty)
                    .opacity(viewModel.isUsernameEmpty ? 0.8 : 1.0)
                    .padding(.horizontal, 48)
                    .padding(.bottom, 24)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button() {
                            dismissKeyboard()
                        } label: { Image(systemName: KeyboardConstants.imageTitle) }
                    }
                }
                .navigationDestination(isPresented: $viewModel.isShowingFollowersView) { viewModel.createFollowersView() }
                .alert(item: $viewModel.alertItem, content: { $0.alert })
            }
        }
    }
}

#Preview {
    SearchView()
}
