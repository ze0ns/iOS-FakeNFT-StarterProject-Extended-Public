//
//  MockCartService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/30.
//
import Foundation

final class MockCartService: CartServiceProtocol {
    var items: [NFTItem] = []
    var paymentResponse = PaymentResponse(success: true, orderId: "1", id: "1")
    var networkError: PaymentError?
    var paymentError: PaymentError?

    init(items: [NFTItem] = [], networkError: PaymentError? = nil, paymentError: PaymentError? = nil) {
            self.items = items
            self.networkError = networkError
            self.paymentError = paymentError
        }
    
    func fetchCartItems() async throws -> [NFTItem] {
        if let networkError {
            throw networkError
        }
        return items
    }

    func removeItem(id: String) async throws -> [NFTItem] {
        if let networkError {
            throw networkError
        }
        
        items.removeAll { $0.id == id }
        return items
    }

    func pay(currencyID: String) async throws -> PaymentResponse {
        if let paymentError {
            throw paymentError
        }
        
        if let networkError {
            throw networkError
        }

        return paymentResponse
    }
}
