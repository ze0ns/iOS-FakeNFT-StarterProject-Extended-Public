//
//  MyNftServicePreviewStub.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 01.08.2026.
//

import Foundation

#if DEBUG
/// Сервис NFT для превью: отдаёт заготовленные данные без сети.
actor MyNftServicePreviewStub: MyNftService {

    private let nfts: [Nft]

    init(nfts: [Nft] = Nft.previews) {
        self.nfts = nfts
    }

    func loadNfts(ids: [String]) async throws -> [Nft] {
        nfts
    }
}
#endif
