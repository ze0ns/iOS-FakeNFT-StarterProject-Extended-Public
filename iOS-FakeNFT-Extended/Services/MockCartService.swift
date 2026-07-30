//
//  MockCartService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/30.
//

protocol CartServiceProtocol {
    func fetchCartItems() async throws -> [NFTItem]
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
