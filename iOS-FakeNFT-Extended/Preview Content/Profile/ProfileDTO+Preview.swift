//
//  ProfileDTO+Preview.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 09.08.2026.
//

import Foundation

#if DEBUG
extension ProfileDTO {

    static let preview = ProfileDTO(
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
