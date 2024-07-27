//
//  SearchView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 13.07.2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                
                VStack {
                    LogoView(frameWidth: 180)
                        .padding(.top, 96)
                        .padding(.bottom, 24)
                    
                    TextField(SearchViewConstants.textFieldText, text: $viewModel.username)
                        .modifier(CustomTextFieldModifier())
                        .padding(.horizontal, 48)
                        .onSubmit { checkIsEmpty() }
                    
                    Spacer()
                    
                    Button {
                        showFollowersView()
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
                .navigationDestination(isPresented: $viewModel.isShowingFollowersView) { viewModel.createFollowersView(selectedUsername: viewModel.username) }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button() {
                            dismissKeyboard()
                        } label: { Image(systemName: KeyboardConstants.imageTitle) }
                    }
                }
                .resignKeyboardOnDragGesture()
            }
        }
    }
    
    private func checkIsEmpty() {
        if !viewModel.isUsernameEmpty {
            showFollowersView()
        } else {
            Toast.shared.present(title: ToastConstants.invalidUsernameMessage, symbol: ToastConstants.invalidUsernameImageTitle, tint: Color(.systemRed))
        }
    }
    
    private func showFollowersView() {
        viewModel.isShowingFollowersView = true
    }
}

#Preview {
    SearchView()
}
