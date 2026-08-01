//
//  ProfileModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//


import Foundation

// MARK: - ProfileModel
struct ProfileModel: Decodable, Sendable, Encodable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]
    let id: String

    var avatarURL: URL? { URL(string: avatar) }
    var websiteURL: URL? { URL(string: website) }

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case avatar = "avatar"
        case description = "description"
        case website = "website"
        case nfts = "nfts"
        case likes = "likes"
        case id = "id"
    }
}
