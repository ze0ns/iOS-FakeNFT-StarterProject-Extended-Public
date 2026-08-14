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
    
    private let storage: StorageService

    private let networkClient: NetworkClient
    
    init(storage: StorageService, networkClient: NetworkClient) {
        self.storage = storage
        self.networkClient = networkClient
    }
    
    func loadCollections() async throws -> CollectionModel {
        let request = APIRequest.collections
        let collections: CollectionModel = try await networkClient.send(request: request)
        await storage.saveCollections(collections)
        return collections
    }
    func loadCollectionByID(id: String) async throws -> CollectionModelElement {
        let request = APIRequest.collectionsByID(id: id)
        let collection: CollectionModelElement = try await networkClient.send(request: request)
        await storage.saveCollection(collection)
        return collection
        
    }
}

