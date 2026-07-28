//
//  UserModelElement.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//



import Foundation

// MARK: - UserModelElement
struct UserModelElement: Codable {
    let name: String
    let avatar: String
    let description: String?
    let website: String
    let nfts: [String]
    let rating: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case avatar = "avatar"
        case description = "description"
        case website = "website"
        case nfts = "nfts"
        case rating = "rating"
        case id = "id"
    }
}

typealias UsersModel = [UserModelElement]
