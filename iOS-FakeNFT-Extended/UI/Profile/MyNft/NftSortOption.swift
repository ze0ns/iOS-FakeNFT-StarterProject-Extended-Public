//
//  NftSortOption.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 01.08.2026.
//

import Foundation

/// Критерий сортировки списка NFT. Выбор сохраняется между запусками.
enum NftSortOption: String, CaseIterable {
    case price
    case rating
    case name

    static let `default` = NftSortOption.rating

    var titleKey: String {
        switch self {
        case .price:
            ProfileStrings.sortByPrice
        case .rating:
            ProfileStrings.sortByRating
        case .name:
            ProfileStrings.sortByName
        }
    }

    func compare(_ lhs: Nft, _ rhs: Nft) -> Bool {
        switch self {
        case .price:
            lhs.price < rhs.price
        case .rating:
            lhs.rating > rhs.rating
        case .name:
            lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
        }
    }
}
