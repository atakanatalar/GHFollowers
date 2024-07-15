//
//  SearchView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 13.07.2024.
//

import SwiftUI

struct SearchView: View {
    @State var username: String = ""
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            VStack {
                LogoView(frameWidth: 200)
                    .padding(.top, 96)
                    .padding(.bottom, 24)
                    
                TextField("Enter a username", text: $username)
                    .modifier(CustomTextFieldModifier())
                    .padding(.horizontal, 48)
                    .onSubmit { print("go button tapped") }
                
                Spacer()
                
                Button {
                    print("get followers button tapped")
                } label: {
                    Label("Get Followers", systemImage: "person.3")
                        .frame(maxWidth: .infinity, maxHeight: 48)
                }
                .modifier(CustomButtonModifier(backgroundColor: Color(.systemGreen)))
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
        }
    }
}

#Preview {
    SearchView()
}
