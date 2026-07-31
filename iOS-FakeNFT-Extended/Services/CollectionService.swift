//
//  CollectionService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//  Получение коллекций NFT


import Foundation

protocol CollectionService {
    func loadCollections() async throws -> CollectionModel
    func loadCollectionByID(id: String) async throws -> CollectionModelElement
}

@MainActor
final class CollectionServiceImpl: CollectionService {

    private let storage: AppStorage
    private let networkClient: NetworkClient
    
    init(storage: AppStorage, networkClient: NetworkClient) {
        self.storage = storage
        self.networkClient = networkClient
    }
    
    func loadCollections() async throws -> CollectionModel {
        let request = APIRequest.collections
        
        do {
            let collections: CollectionModel = try await networkClient.send(request: request)
            print("✅ Данные успешно скачаны из сети")
            await storage.saveCollections(collections)
            return collections
        } catch {
            print("❌ Ошибка при загрузке из сети: \(error.localizedDescription)")
            throw error
        }
    }
    func loadCollectionByID(id: String) async throws -> CollectionModelElement {
        let request = APIRequest.collectionsByID(id: id)
        
        do {
            let collection: CollectionModelElement = try await networkClient.send(request: request)
            print("✅ Данные успешно скачаны из сети")
            await storage.saveCollection(collection)
            return collection
        } catch {
            print("❌ Ошибка при загрузке из сети: \(error.localizedDescription)")
            throw error
        }
    }
}
