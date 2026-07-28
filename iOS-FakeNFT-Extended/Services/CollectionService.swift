//
//  CollectionService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//


import Foundation

protocol CollectionService {
    func loadCollection() async throws -> CollectionModel
}

@MainActor
final class CollectionServiceImpl: CollectionService {

    private let networkClient: NetworkClient
    private let storage: CollectionStorage

    init(networkClient: NetworkClient, storage: CollectionStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func loadCollection() async throws -> CollectionModel {
        if let collections = await storage.getCollection() {
            return collections
        }

        let request = CollectionRequest()
        let collections: CollectionModel = try await networkClient.send(request: request)
        await storage.saveCollection(collections)
        return collections
    }
}
