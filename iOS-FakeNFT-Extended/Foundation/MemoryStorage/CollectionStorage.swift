//
//  NftStorage 2.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//


import Foundation

protocol CollectionStorage: AnyObject {
    func saveCollection(_ collectionNft: CollectionModel) async
    func getCollection() async -> CollectionModel?
}

// Пример простого актора, который сохраняет данные из сети
actor CollectionStorageImpl: CollectionStorage {
    private var storage: CollectionModel = []
    func saveCollection(_ collectionNft: CollectionModel) async {
        storage = collectionNft
    }
    
    func getCollection() async -> CollectionModel? {
        storage
    }
    
}
