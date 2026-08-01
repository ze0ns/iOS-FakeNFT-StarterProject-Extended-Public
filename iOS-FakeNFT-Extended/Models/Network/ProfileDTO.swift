//
//  ProfileDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//


import Foundation

/// Объект передачи данных, описывающий профиль пользователя,
/// получаемый от сервера.
struct ProfileDTO: Codable, Sendable {

    /// Имя пользователя.
    let name: String

    /// Ссылка на изображение аватара.
    let avatar: String

    /// Описание профиля пользователя.
    let description: String

    /// Ссылка на сайт пользователя.
    let website: String

    /// Идентификаторы NFT, принадлежащих пользователю.
    let nfts: [String]

    /// Идентификаторы NFT, добавленных в избранное.
    let likes: [String]

    /// Идентификатор профиля.
    let id: String

    /// Адрес аватара, пригодный для загрузки, или `nil`, если ссылка некорректна.
    var avatarURL: URL? { URL(string: avatar) }

    /// Адрес сайта пользователя, пригодный для открытия, или `nil`, если ссылка некорректна.
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
