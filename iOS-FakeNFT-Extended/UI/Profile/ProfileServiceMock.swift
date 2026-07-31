//
//  ProfileServiceMock.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 28.07.2026.
//

import Foundation

actor ProfileServiceMock: ProfileService {

    func loadProfile() async throws -> ProfileModel {
        ProfileModel.mock
    }

    func updateProfile(profile: ProfileModel) async throws -> ProfileModel {
        profile
    }
}

extension ProfileModel {

    static let mock = ProfileModel(
        name: "Joaquin Phoenix",
        avatar: "https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG",
        description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
        website: "https://practicum.yandex.ru",
        nfts: Array(repeating: "nft", count: 112),
        likes: Array(repeating: "like", count: 11),
        id: "1"
    )
}
