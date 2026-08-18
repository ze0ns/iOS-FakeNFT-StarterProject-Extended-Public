//
//  Formatter+NFTPrice.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 05.08.2026.
//

import Foundation

extension Formatter {
    static let nftPrice: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}
