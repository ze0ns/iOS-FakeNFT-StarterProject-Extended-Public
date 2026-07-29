//
//  NftStorage 2.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//


import Foundation

protocol CollectionStorage: AnyObject {
    func saveCollection(_ collection: CollectionModelElement) async
    func getCollection() async -> CollectionModelElement?
}
protocol CollectionsStorage: AnyObject {
    func saveCollection(_ collections: CollectionModel) async
    func getCollection() async -> CollectionModel?
}


actor CollectionStorageImpl: CollectionStorage {
    private var storage: CollectionModelElement?
    func saveCollection(_ collection: CollectionModelElement) async {
        storage = collection
    }
    
    func getCollection() async -> CollectionModelElement? {
        storage
    }
    
}
actor CollectionsStorageImpl: CollectionsStorage {
    private var storage: CollectionModel = []
    func saveCollection(_ collections: CollectionModel) async {
        storage = collections
    }
    
    func getCollection() async -> CollectionModel? {
        storage
    }
    
}
