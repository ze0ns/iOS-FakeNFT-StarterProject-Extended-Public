//
//  AppStorage .swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//

import Foundation

protocol StorageService: AnyObject {
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
    
    // Array NFT
    func saveArrayNft(_ nft: [NftArrayElement]) async
    func getNfts() async -> [NftArrayElement]?
    
    // Array Currencies
    func saveCurrency(_ Currency: [Currency]) async
    func getCurrency() async -> [Currency]?
    
    // Profile
    func saveProfile(_ Profile: ProfileModel) async
    func getProfile() async -> ProfileModel?
    
    // Orders
    func saveOrders(_ Orders: OrdersModel) async
    func getOrders() async -> OrdersModel?
}


actor AppStorageImpl: StorageService {


    // Приватные хранилища для каждого типа данных
    private var collectionStorage: CollectionModelElement?
    private var collectionsStorage: CollectionModel = []
    private var usersStorage: UsersModel = []
    private var nftsStorage: [String: Nft] = [:]
    private var nftArrayStorage: [NftArrayElement] = []
    private var currencyStorage: [Currency] = []
    private var profileStorage: ProfileModel?
    private var ordersStorage: OrdersModel?

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
    func saveArrayNft(_ arrayNft: [NftArrayElement]) async {
        nftArrayStorage = arrayNft
    }
    
    func getNfts() async -> [NftArrayElement]? {
        nftArrayStorage.isEmpty ? nil : nftArrayStorage
    }
    
    // MARK: - Currency
    func saveCurrency(_ Currency: [Currency]) async {
        currencyStorage = Currency
    }
    
    func getCurrency() async -> [Currency]? {
        currencyStorage.isEmpty ? nil : currencyStorage
    }
   
    // MARK: - Currency
    func saveProfile(_ Profile: ProfileModel) async {
        profileStorage = Profile
    }
    
    func getProfile() async -> ProfileModel? {
        profileStorage
    }
    
    // MARK: - Orders
    func saveOrders(_ Orders: OrdersModel) async {
        ordersStorage = Orders
    }
    
    func getOrders() async -> OrdersModel? {
        ordersStorage
    }
    

    
}
