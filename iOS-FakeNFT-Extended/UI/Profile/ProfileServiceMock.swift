//
//  ProfileServiceMock.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 28.07.2026.
//

import Foundation

actor ProfileServiceMock: ProfileService {

    func loadProfile(id: String) async throws -> Profile {
        Profile.mock
    }

    func invalidateCache() {}
}

extension Profile {

    static let mock = Profile(
        id: "1",
        name: "Joaquin Phoenix",
        description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
        website: "https://practicum.yandex.ru",
        avatar: "https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG",
        nfts: Array(repeating: "nft", count: 112),
        likes: Array(repeating: "like", count: 11)
    )
}
