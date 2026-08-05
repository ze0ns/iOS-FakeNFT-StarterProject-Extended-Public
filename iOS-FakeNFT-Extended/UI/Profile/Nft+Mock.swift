//
//  Nft+Mock.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 01.08.2026.
//

import Foundation

#if DEBUG
extension Nft {

    static let mock = Nft(
        id: "1464520d-1659-4055-8a79-4593b9569e48",
        name: "Lilo",
        images: [
            URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Yellow/Helga/1.png")
        ].compactMap { $0 },
        rating: 3,
        price: 1.78,
        author: "John Doe"
    )

    static let mocks: [Nft] = [
        Nft(id: "1", name: "Lilo", images: [], rating: 3, price: 1.78, author: "John Doe"),
        Nft(id: "2", name: "Spring", images: [], rating: 4, price: 1.22, author: "John Doe"),
        Nft(id: "3", name: "April", images: [], rating: 5, price: 2.34, author: "John Doe")
    ]
}
#endif
