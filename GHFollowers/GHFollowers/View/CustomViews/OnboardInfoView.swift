//
//  OnboardInfoView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 22.07.2024.
//

import SwiftUI

struct OnboardInfoView: View {
    var imageTitle: String
    var title: String
    var description: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: imageTitle)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.callout)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
        }
    }
}

#Preview {
    OnboardInfoView(imageTitle: OnboardViewConstants.viewFollowersImageTitle,
                    title: OnboardViewConstants.viewFollowersTitle,
                    description: OnboardViewConstants.viewFollowersDescription)
}
