//
//  LeaderboardCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//

import SwiftUI

struct UserInfoCell: View {
    let name: String
    let score: Int
    let avatarUrl: String
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: avatarUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 44, height: 44)
            .clipShape(Circle())

            Text(name)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.black)
          
            Spacer()
            
            Text("\(score)")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.black)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(red: 0.96, green: 0.96, blue: 0.97))
        .cornerRadius(16)
    }
}
