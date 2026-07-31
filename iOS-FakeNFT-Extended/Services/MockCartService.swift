//
//  MockCartService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/30.
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
                imageName: $0.images.first ?? "",
                rating: $0.rating,
                price: Decimal($0.price),
                currency: .btc,
                sellerName: $0.author
            )
        }
    }
}

struct MockCartService: CartServiceProtocol {
    
    var delay: Duration = .seconds(1)
    var itemsToReturn: [NFTItem] = [
        .mockOlaf,
        .mockHelga,
        .mockVulcan,
        .mockFlorine,
        .mockPumpkin,
        .mockWillow
    ]
    
    func fetchCartItems() async throws -> [NFTItem] {
        try await Task.sleep(for: delay)
        return itemsToReturn
    }
}

struct FailingCartService: CartServiceProtocol {
    func fetchCartItems() async throws -> [NFTItem] {
        throw URLError(.notConnectedToInternet)
    }
}
