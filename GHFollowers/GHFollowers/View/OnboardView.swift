//
//  OnboardView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 22.07.2024.
//

import SwiftUI

struct OnboardView: View {
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    @Binding var isShowingOnboardView: Bool
    
    var body: some View {
        VStack {
            LogoView(frameWidth: 180)
                .padding(.top, 96)
                .padding(.bottom,32)
            
            VStack(alignment: .leading, spacing: 24) {
                OnboardInfoView(imageTitle: OnboardViewConstants.viewFollowersImageTitle,
                                title: OnboardViewConstants.viewFollowersTitle,
                                description: OnboardViewConstants.viewFollowersDescription)
                
                OnboardInfoView(imageTitle: OnboardViewConstants.profileViewingImageTitle,
                                title: OnboardViewConstants.profileViewingTitle,
                                description: OnboardViewConstants.profileViewingDescription)
                
                OnboardInfoView(imageTitle: OnboardViewConstants.favoritesListImageTitle,
                                title: OnboardViewConstants.favoritesListTitle,
                                description: OnboardViewConstants.favoritesListDescription)
            }
            .padding(.horizontal,36)
            
            Spacer()
            
            Button {
                isFirstTime = false
                isShowingOnboardView = false
            } label: {
                Label(OnboardViewConstants.buttonTitle, systemImage: OnboardViewConstants.buttonImageTitle)
                    .frame(maxWidth: .infinity, maxHeight: 48)
            }
            .modifier(CustomButtonModifier(backgroundColor: Color(.systemGreen)))
            .padding(.horizontal, 48)
            .padding(.bottom, 24)
        }
    }
}

#Preview {
    OnboardView(isShowingOnboardView: .constant(true))
}
