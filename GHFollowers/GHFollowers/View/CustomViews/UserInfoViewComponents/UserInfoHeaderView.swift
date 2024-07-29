//
//  UserInfoHeaderView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 17.07.2024.
//

import SwiftUI

struct UserInfoHeaderView: View {
    let user: User
    let dynamicTypeSize: DynamicTypeSize
    
    var body: some View {
        if dynamicTypeSize >= .accessibility1 {
            bigSizeHeaderView
        } else {
            normalSizeHeaderView
        }
    }
    
    var normalSizeHeaderView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top, spacing: 12) {
                    AvatarView(url: user.avatarUrl, height: dynamicTypeSize >= .accessibility1 ? 240 : 120)
                    
                    VStack(alignment: .leading) {
                        Text(user.login)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .lineLimit(1)
                        
                        Text(user.name ?? "Name")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                        
                        Label(user.location ?? "No Location", systemImage: "mappin.and.ellipse")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }
                .padding(.top)
                
                Text(user.bio ?? "No bio available")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
            }
            
            Spacer()
        }
    }
    
    var bigSizeHeaderView: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .center, spacing: 20) {
                AvatarView(url: user.avatarUrl, height: dynamicTypeSize >= .accessibility1 ? 240 : 120)
                
                VStack {
                    Text(user.login)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(user.name ?? "Name")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                    
                    Label(user.location ?? "No Location", systemImage: "mappin.and.ellipse")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                }
                
                Text(user.bio ?? "No bio available")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
    }
}

#Preview {
    UserInfoHeaderView(user: MockData.user, dynamicTypeSize: .medium)
}
