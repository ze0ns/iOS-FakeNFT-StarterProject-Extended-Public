//
//  UserCardView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 01.08.2026.
//

import SwiftUI

struct UserCardView: View {
    
    let userInfo: UserModelElement
    
    // Зависимости для создания следующего экрана (DI)
    private let nftService: MyNftService
    private let profileService: ProfileService
    private let onProfileUpdated: (ProfileDTO) -> Void
    
    init(
        userInfo: UserModelElement,
        nftService: MyNftService,
        profileService: ProfileService,
        onProfileUpdated: @escaping (ProfileDTO) -> Void
    ) {
        self.userInfo = userInfo
        self.nftService = nftService
        self.profileService = profileService
        self.onProfileUpdated = onProfileUpdated
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // Основное содержимое
            VStack(alignment: .leading, spacing: 16) {
                
                // Карточка пользователя
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 20) {
                        AsyncImage(url: URL(string: userInfo.avatar)) { phase in
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
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        
                        Text(userInfo.name)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    
                    // Описание
                    Text(userInfo.description ?? " ")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .lineSpacing(4)
                }
                .padding(.top, 40)
                
                Button(action: {
                    print("Показать все NFT")
                }) {
                    Text("Перейти на сайт пользователя")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(.white)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.black, lineWidth: 0.5)
                        )
                }
                .padding(.bottom, 20)
                
                // Переход на коллекцию NFT
                NavigationLink {
                    UserCollectionsNFTView(
                        likeIds: userInfo.nfts,
                        service: nftService,
                        profileService: profileService,
                        onProfileUpdated: onProfileUpdated
                    )
                } label: {
                    HStack {
                        Text("Коллекция NFT (\(userInfo.nfts.count))")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .buttonStyle(.plain) // Убирает стандартный синий tint у NavigationLink
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
    }
}
#Preview {
    NavigationStack {
        UserCardView(
            userInfo:UserModelElement(name: "user-1",
                                      avatar: "Helga Storm",
                                      description: "https://code.s3.yandex.net/Mobile/iOS/NFT/Default/Avatar.png",
                                      website: "Digital artist & NFT collector. Creating unique pieces of art.",
                                      nfts: ["nft-1", "nft-2", "nft-3", "nft-4", "nft-5"],
                                      rating: "3",
                                      id: "1111"),
            nftService:  MyNftServicePreviewStub(),
            profileService: ProfileServicePreviewStub(),
            onProfileUpdated: { _ in }
        )
    }
}
