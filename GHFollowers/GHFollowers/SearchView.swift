//
//  SearchView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 13.07.2024.
//

import SwiftUI

struct SearchView: View {
    @State var username: String = ""
    @State var alertItem: AlertItem?
    @State var navigateToFollowers: Bool = false
    
    var isUsernameEmpty: Bool { return username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                
                VStack {
                    LogoView(frameWidth: 200)
                        .padding(.top, 96)
                        .padding(.bottom, 24)
                    
                    TextField("Enter a username", text: $username)
                        .modifier(CustomTextFieldModifier())
                        .padding(.horizontal, 48)
                        .onSubmit {
                            if !isUsernameEmpty {
                                navigateToFollowers = true
                            } else {
                                alertItem = AlertContext.invalidUsername
                            }
                        }
                    
                    Spacer()
                    
                    Button {
                        navigateToFollowers = true
                    } label: {
                        Label("Get Followers", systemImage: "person.3")
                            .frame(maxWidth: .infinity, maxHeight: 48)
                    }
                    .modifier(CustomButtonModifier(backgroundColor: Color(.systemGreen)))
                    .disabled(isUsernameEmpty)
                    .opacity(isUsernameEmpty ? 0.8 : 1.0)
                    .padding(.horizontal, 48)
                    .padding(.bottom, 24)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button() {
                            dismissKeyboard()
                        } label: { Image(systemName: "keyboard.chevron.compact.down") }
                    }
                }
                .navigationDestination(isPresented: $navigateToFollowers) { FollowersView() }
                .alert(item: $alertItem, content: { $0.alert })
            }
        }
    }
}

#Preview {
    SearchView()
}
