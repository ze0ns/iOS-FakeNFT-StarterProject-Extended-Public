//
//  CartService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/31.
//
import Foundation

protocol CartServiceProtocol {
    func fetchCartItems() async throws -> [NFTItem]
}

final class CartService: CartServiceProtocol {

    private let nftService: NftService

    init(nftService: NftService) {
        self.nftService = nftService
    }

    func fetchCartItems() async throws -> [NFTItem] {
        let nftItems = try await nftService.loadArrayNft()

        return nftItems.map {
            NFTItem(
                id: $0.id,
                name: $0.name,
                imageURL: URL(string: $0.images.first ?? ""),
                imageName: nil,
                rating: $0.rating,
                price: Decimal($0.price),
                currency: .btc,
                sellerName: $0.author
            )
        }
    }
}
