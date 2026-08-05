//
//  Double+NFTPrice.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 05.08.2026.
//

import Foundation

extension Double {
    /// Цена NFT в виде «1,78 ETH». Разделитель берётся из локали пользователя.
    var nftPriceText: String {
        let amount = Formatter.nftPrice.string(
            from: NSNumber(value: self)
        ) ?? String(self)

        return String(
            format: NSLocalizedString(
                ProfileStrings.priceFormat,
                comment: ""
            ),
            amount
        )
    }
}
