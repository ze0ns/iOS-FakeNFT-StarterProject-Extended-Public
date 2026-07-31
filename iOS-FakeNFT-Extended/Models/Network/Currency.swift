//
//  Currency.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 29.07.2026.
//


import Foundation

// MARK: - Currency
struct Currency: Codable {
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