//
//  MockCartService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/30.
//
import Foundation

final class MockCartService: CartServiceProtocol {
    
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
    
    func removeItem(id: String) async throws -> [NFTItem] {
        itemsToReturn.removeAll { $0.id == id }
        return itemsToReturn
    }
}

final class FailingCartService: CartServiceProtocol {
    func fetchCartItems() async throws -> [NFTItem] {
        throw URLError(.notConnectedToInternet)
    }
    
    func removeItem(id: String) async throws -> [NFTItem] {
        return []
    }
}
