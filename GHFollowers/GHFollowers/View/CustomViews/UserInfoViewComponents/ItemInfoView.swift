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
    var itemInfoType: ItemInfoType
    var count: Int
        
    private var label: Label<Text, Image> {
        switch itemInfoType {
        case .repos:
            return Label("Public Repos", systemImage: "folder")
        case .gists:
            return Label("Public Gists", systemImage: "text.alignleft")
        case .followers:
            return Label("Followers", systemImage: "heart")
        case .following:
            return Label("Following", systemImage: "person.2")
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            HStack(spacing: 20) {
                label
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
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
