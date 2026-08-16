//
//  StatisticsNftCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 15.08.2026.
//

import Kingfisher
import SwiftUI

struct StatisticsNftCellView: View {
    
    let nft: Nft
    let isLiked: Bool // Новое свойство для отслеживания состояния лайка
    let onFavoriteTap: () -> Void
    let onCartTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            KFImage(nft.coverURL)
                .resizable()
                .placeholder {
                    Rectangle()
                        .fill(Color(.lightGrayPrimary))
                }
                .scaledToFill()
                .frame(width: 108, height: 108)
                .clipShape(.rect(cornerRadius: 12))
                .overlay(alignment: .topTrailing) {
                    favoriteButton
                }
            
            NftRatingView(rating: nft.rating)
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(nft.name)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(Color(.blackPrimary))
                        .lineLimit(2)
                        .truncationMode(.tail)
                    
                    Text(nft.price.nftPriceText)
                        .font(.system(size: 15))
                        .foregroundStyle(Color(.blackPrimary))
                }
                
                Spacer()
                
                Button(action: onCartTap) {
                    Image(.cartAdd)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Добавить в корзину")
            }
        }
    }
    
    private var favoriteButton: some View {
        Button(action: onFavoriteTap) {
            // В зависимости от isLiked показываем красное или серое сердечко
            Image(isLiked ? .like : .noLike) 
                .foregroundStyle(isLiked ? Color(.redUniversal) : Color(.grayUniversal))
                .padding(6)

        }
        .buttonStyle(.plain)
        .padding(4)
        .accessibilityLabel(isLiked ? "Убрать из избранного" : "Добавить в избранное")
    }
}

#Preview {
    let previewCell = Nft(
        id: "1464520d-1659-4055-8a79-4593b9569e48",
        name: "Zeus",
        images: [
            URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Yellow/Helga/2.png")
        ].compactMap { $0 },
        rating: 3,
        price: 1.78,
        author: "John Doe"
    )
    // В превью передаем isLiked: true или false
    StatisticsNftCellView(nft: previewCell, isLiked: true, onFavoriteTap: {}, onCartTap: {})
}
