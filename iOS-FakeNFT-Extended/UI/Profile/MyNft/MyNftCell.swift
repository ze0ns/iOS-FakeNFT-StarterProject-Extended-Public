//
//  MyNftCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 01.08.2026.
//

import Kingfisher
import SwiftUI

struct MyNftCell: View {

    let nft: Nft

    var body: some View {
        HStack(spacing: 20) {
            KFImage(nft.coverURL)
                .resizable()
                .placeholder {
                    Rectangle()
                        .fill(Color(.lightGrayPrimary))
                }
                .scaledToFill()
                .frame(width: 108, height: 108)
                .clipShape(.rect(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 4) {
                Text(nft.name)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(Color(.blackPrimary))
                    .lineLimit(1)
                    .truncationMode(.tail)

                NftRatingView(rating: nft.rating)

                Text(authorText)
                    .font(.system(size: 13))
                    .foregroundStyle(Color(.blackPrimary))
                    .lineLimit(1)
                    .truncationMode(.tail)
            }

            Spacer(minLength: 8)

            VStack(alignment: .leading, spacing: 2) {
                Text(NSLocalizedString(ProfileStrings.priceTitle, comment: ""))
                    .font(.system(size: 13))
                    .foregroundStyle(Color(.blackPrimary))

                Text(NftPriceFormatter.string(from: nft.price))
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(Color(.blackPrimary))
            }
        }
        .frame(height: 108)
    }

    private var authorText: String {
        String(
            format: NSLocalizedString(ProfileStrings.authorFormat, comment: ""),
            nft.author
        )
    }
}

#if DEBUG
#Preview {
    List {
        MyNftCell(nft: .mock)
        MyNftCell(nft: .mock)
    }
    .listStyle(.plain)
}
#endif
