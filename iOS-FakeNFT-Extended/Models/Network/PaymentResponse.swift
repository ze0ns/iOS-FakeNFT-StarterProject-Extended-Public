//
//  PaymentResponse.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/8/12.
//

struct PaymentResponse: Decodable {
    let success: Bool
    let orderId: String?
    let id: String?
}
