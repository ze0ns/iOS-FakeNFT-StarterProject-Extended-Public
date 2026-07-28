//
//  CollectionService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//  Получение коллекций NFT


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
        let request = CollectionRequest()
        
        do {
            let collections: CollectionModel = try await networkClient.send(request: request)
            print("✅ Данные успешно скачаны из сети")
            await storage.saveCollection(collections)
            return collections
        } catch {
            print("❌ Ошибка при загрузке из сети: \(error.localizedDescription)")
            throw error
        }
    }
}
