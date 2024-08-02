//
//  SearchView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 13.07.2024.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                
                VStack {
                    LogoView(frameWidth: 180)
                        .padding(.top, 96)
                        .padding(.bottom, 24)
                        .accessibilityLabel(SearchViewConstants.accessibilityLabelAppLogo)
                    
                    TextField(SearchViewConstants.textFieldText, text: $viewModel.username)
                        .modifier(CustomTextFieldModifier(text: $viewModel.username, dynamicTypeSize: dynamicTypeSize))
                        .animation(.easeInOut, value: viewModel.username)
                        .padding(.horizontal, 48)
                        .onSubmit { checkIsEmpty() }
                    
                    Spacer()
                    
                    Button {
                        showFollowersView()
                    } label: {
                        Label(SearchViewConstants.buttonTitle, systemImage: SearchViewConstants.buttonImageTitle)
                            .frame(maxWidth: .infinity)
                            .frame(height: dynamicTypeSize >= .accessibility1 ? 72 : 48)
                    }
                    .modifier(CustomButtonModifier(backgroundColor: Color(.systemGreen)))
                    .disabled(viewModel.isUsernameEmpty)
                    .opacity(viewModel.isUsernameEmpty ? 0.6 : 1.0)
                    .padding(.horizontal, 48)
                    .padding(.bottom, 24)
                    .accessibilityHint(SearchViewConstants.accessibilityHintButton)
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
