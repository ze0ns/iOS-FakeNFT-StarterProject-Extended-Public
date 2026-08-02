//
//  FavoriteNftCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 01.08.2026.
//

import Kingfisher
import SwiftUI

struct FavoriteNftCell: View {

    let nft: Nft
    let onFavoriteTap: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            KFImage(nft.coverURL)
                .resizable()
                .placeholder {
                    Rectangle()
                        .fill(Color(.lightGrayPrimary))
                }
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(.rect(cornerRadius: 12))
                .overlay(alignment: .topTrailing) {
                    favoriteButton
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(nft.name)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(Color(.blackPrimary))
                    .lineLimit(2)
                    .truncationMode(.tail)

                NftRatingView(rating: nft.rating)

                Text(NftPriceFormatter.string(from: nft.price))
                    .font(.system(size: 15))
                    .foregroundStyle(Color(.blackPrimary))
            }

            Spacer(minLength: 0)
        }
    }

    private var favoriteButton: some View {
        Button(action: onFavoriteTap) {
            Image(systemName: ProfileIcons.favoriteFilled)
                .font(.system(size: 12))
                .foregroundStyle(Color(.redUniversal))
                .padding(6)
                .background(Color(.whiteUniversal).opacity(0.6))
                .clipShape(.circle)
        }
        .buttonStyle(.plain)
        .padding(4)
    }
}

#if DEBUG
#Preview {
    FavoriteNftCell(nft: .mock, onFavoriteTap: {})
        .padding(16)
}
#endif
