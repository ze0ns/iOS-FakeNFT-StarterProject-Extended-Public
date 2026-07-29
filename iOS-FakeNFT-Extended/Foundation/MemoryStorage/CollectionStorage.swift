//
//  AppStorage .swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//

import Foundation

// 1. Единый протокол, объединяющий все обязанности
protocol AppStorage: AnyObject {
    // Single Collection
    func saveCollection(_ collection: CollectionModelElement) async
    func getCollection() async -> CollectionModelElement?
    
    // Array of Collections
    func saveCollections(_ collections: CollectionModel) async
    func getCollections() async -> CollectionModel?
    
    // Users
    func saveUsers(_ usersInfo: UsersModel) async
    func getUsers() async -> UsersModel?
    
    // NFT
    func saveNft(_ nft: Nft) async
    func getNft(with id: String) async -> Nft?
}

// 2. Единый Actor, реализующий этот протокол
actor AppStorageImpl: AppStorage {
    // Приватные хранилища для каждого типа данных
    private var collectionStorage: CollectionModelElement?
    private var collectionsStorage: CollectionModel = []
    private var usersStorage: UsersModel = []
    private var nftsStorage: [String: Nft] = [:]

    // MARK: - Single Collection
    func saveCollection(_ collection: CollectionModelElement) async {
        collectionStorage = collection
    }
    
    func getCollection() async -> CollectionModelElement? {
        collectionStorage
    }
    
    // MARK: - Collections Array
    func saveCollections(_ collections: CollectionModel) async {
        collectionsStorage = collections
    }
    
    func getCollections() async -> CollectionModel? {
        collectionsStorage.isEmpty ? nil : collectionsStorage
    }
    
    // MARK: - Users
    func saveUsers(_ usersInfo: UsersModel) async {
        usersStorage = usersInfo
    }
    
    func getUsers() async -> UsersModel? {
        usersStorage.isEmpty ? nil : usersStorage
    }
    
    // MARK: - NFT
    func saveNft(_ nft: Nft) async {
        nftsStorage[nft.id] = nft
    }
    
    func getNft(with id: String) async -> Nft? {
        nftsStorage[id]
    }
}
