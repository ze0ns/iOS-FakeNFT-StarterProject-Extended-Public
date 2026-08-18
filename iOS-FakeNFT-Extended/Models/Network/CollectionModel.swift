//
//  CollectionModelElement.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//

import Foundation

// MARK: - CollectionModelElement
struct CollectionModelElement: Codable {
    let createdAt: String
    let name: String
    let cover: String
    let nfts: [String]
    let description: String
    let author: String
    let website: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case name = "name"
        case cover = "cover"
        case nfts = "nfts"
        case description = "description"
        case author = "author"
        case website = "website"
        case id = "id"
    }
}

typealias CollectionModel = [CollectionModelElement]
