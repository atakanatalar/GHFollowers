//
//  ItemInfoView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 17.07.2024.
//

import SwiftUI

enum ItemInfoType {
    case repos, gists, followers, following
}

struct ItemInfoView: View {
    let itemInfoType: ItemInfoType
    let count: Int
    
    private var label: Label<Text, Image> {
        switch itemInfoType {
        case .repos:
            return Label(ItemInfoViewConstants.publicReposTitle, systemImage: ItemInfoViewConstants.publicReposImageTitle)
        case .gists:
            return Label(ItemInfoViewConstants.publicGistsTitle, systemImage: ItemInfoViewConstants.publicGistsImageTitle)
        case .followers:
            return Label(ItemInfoViewConstants.followersTitle, systemImage: ItemInfoViewConstants.followersImageTitle)
        case .following:
            return Label(ItemInfoViewConstants.followingTitle, systemImage: ItemInfoViewConstants.followingImageTitle)
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            label
                .font(.callout)
                .fontWeight(.semibold)
                .truncationMode(.tail)
                .foregroundColor(.primary)
            
            Text("\(count)")
                .font(.callout)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
        .padding(.bottom, 12)
    }
}

#Preview {
    ItemInfoView(itemInfoType: .repos, count: 99)
}
