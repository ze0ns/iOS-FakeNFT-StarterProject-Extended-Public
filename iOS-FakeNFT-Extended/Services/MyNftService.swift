//
//  MyNftService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 01.08.2026.
//

import Foundation

/// Загружает NFT пользователя по списку идентификаторов из профиля.
protocol MyNftService: Sendable {
    func loadNfts(ids: [String]) async throws -> [Nft]
}

actor MyNftServiceImpl: MyNftService {

    private let networkClient: NetworkClient
    private let storage: AppStorage

    init(networkClient: NetworkClient, storage: AppStorage) {
        self.networkClient = networkClient
        self.storage = storage
    }

    func loadNfts(ids: [String]) async throws -> [Nft] {
        try await withThrowingTaskGroup(of: (Int, Nft).self) { group in
            for (index, id) in ids.enumerated() {
                group.addTask {
                    (index, try await self.loadNft(id: id))
                }
            }

            var loaded: [(Int, Nft)] = []
            for try await pair in group {
                loaded.append(pair)
            }

            return loaded
                .sorted { $0.0 < $1.0 }
                .map(\.1)
        }
    }

    private func loadNft(id: String) async throws -> Nft {
        if let cached = await storage.getNft(with: id) {
            return cached
        }

        let nft: Nft = try await networkClient.send(request: APIRequest.nft(id: id))
        await storage.saveNft(nft)
        return nft
    }
}
