//
//  Currencies.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 29.07.2026.
//


import Foundation

// MARK: - Currencies
struct Currencies: Codable {
    let title: String
    let name: String
    let image: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case name = "name"
        case image = "image"
        case id = "id"
    }
}
<<<<<<< HEAD:iOS-FakeNFT-Extended/Models/Network/Currency.swift
=======

struct SetCurrenciesPay: Codable {
    let success: Bool
    let orderId: String
    let id: String
}
>>>>>>> develop:iOS-FakeNFT-Extended/Models/Network/Currencies.swift
