//
//  NftPriceFormatter.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 01.08.2026.
//

import Foundation

/// Приводит цену NFT к виду «1,78 ETH».
enum NftPriceFormatter {

    static func string(from price: Double) -> String {
        let amount = numberFormatter.string(from: NSNumber(value: price)) ?? "\(price)"
        return String(
            format: NSLocalizedString(ProfileStrings.priceFormat, comment: ""),
            amount
        )
    }

    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = ","
        return formatter
    }()
}
