//
//  ProfileServiceMock.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 28.07.2026.
//

import Foundation

#if DEBUG
actor ProfileServiceMock: ProfileService {

    func loadProfile() async throws -> ProfileDTO {
        ProfileDTO.mock
    }

    func updateProfile(profile: ProfileDTO) async throws -> ProfileDTO {
        profile
    }

    func updateLikes(_ likes: [String]) async throws -> ProfileDTO {
        ProfileDTO.mock
    }
}

extension ProfileDTO {

    static let mock = ProfileDTO(
        name: "Joaquin Phoenix",
        avatar: "https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG",
        description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
        website: "https://practicum.yandex.ru",
        nfts: Array(repeating: "nft", count: 112),
        likes: Array(repeating: "like", count: 11),
        id: "1"
    )
}
#endif
