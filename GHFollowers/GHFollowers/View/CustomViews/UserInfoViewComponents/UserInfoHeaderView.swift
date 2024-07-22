//
//  UserInfoHeaderView.swift
//  GHFollowers
//
//  Created by Atakan Atalar on 17.07.2024.
//

import SwiftUI

struct UserInfoHeaderView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 12) {
                AvatarImageView(user: user)
                
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
            .padding(.vertical)
            
            Text(user.bio ?? "No bio available")
                .font(.body)
                .foregroundStyle(.secondary)
                .lineLimit(3)
        }
    }
    
    struct AvatarImageView: View {
        let user: User
        
        var body: some View {
            AsyncImage(url: URL(string: user.avatarUrl)) { phase in
                switch phase {
                case .empty:
                    PlaceholderImageView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                case .failure:
                    PlaceholderImageView()
                @unknown default:
                    PlaceholderImageView()
                }
            }
            .frame(width: 120)
        }
    }
    
    struct PlaceholderImageView: View {
        var body: some View {
            Image(.avatarPlaceholder)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    UserInfoHeaderView(user: User(login: "login", avatarUrl: "", publicRepos: 99, publicGists: 99, htmlUrl: "", following: 99, followers: 99, createdAt: Date.now))
}
