//
//  OrdersModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 30.07.2026.
//

import Foundation

// MARK: - OrdersModel
struct OrdersModel: Codable {
    let nfts: [String]
    let id: String

    enum CodingKeys: String, CodingKey {
        case nfts = "nfts"
        case id = "id"
    }
}
// Вспомогательная структура для updateOrders
struct UpdateOrdersDTO: Encodable {
    let nfts: String
}
