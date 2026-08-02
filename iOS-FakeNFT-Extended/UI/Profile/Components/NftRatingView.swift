//
//  NftRatingView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 01.08.2026.
//

import SwiftUI

struct NftRatingView: View {

    let rating: Int

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...Self.maxRating, id: \.self) { star in
                Image(systemName: ProfileIcons.star)
                    .font(.system(size: 12))
                    .foregroundStyle(
                        star <= rating
                        ? Color(.yellowUniversal)
                        : Color(.lightGrayPrimary)
                    )
            }
        }
    }

    private static let maxRating = 5
}

#if DEBUG
#Preview {
    VStack(alignment: .leading, spacing: 8) {
        NftRatingView(rating: 0)
        NftRatingView(rating: 3)
        NftRatingView(rating: 5)
    }
}
#endif
