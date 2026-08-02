//
//  MyNftServiceMock.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 01.08.2026.
//

import Foundation

#if DEBUG
actor MyNftServiceMock: MyNftService {

    private let nfts: [Nft]

    init(nfts: [Nft] = Nft.mocks) {
        self.nfts = nfts
    }

    func loadNfts(ids: [String]) async throws -> [Nft] {
        nfts
    }
}
#endif
