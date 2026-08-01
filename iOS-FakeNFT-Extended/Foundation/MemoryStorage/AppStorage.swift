//
//  AppStorage .swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//

import Foundation

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
    
    // User Info
    func saveUserInfo(_ usersInfo: UserModelElement) async
    func getUsersInfo() async -> UserModelElement?
    
    // NFT
    func saveNft(_ nft: Nft) async
    func getNft(with id: String) async -> Nft?
    
    // Array NFT
    func saveArrayNft(_ nft: [NftArrayElement]) async
    func getNfts() async -> [NftArrayElement]?
    
    // Currencies
    func saveCurrencies(_ Currencies: Currencies) async
    func getCurrencies() async -> Currencies?
    
    // Array Currencies
    func saveArrayCurrencies(_ Currencies: [Currencies]) async
    func getArrayCurrencies() async -> [Currencies]?
    
    // Profile
    func saveProfile(_ Profile: ProfileModel) async
    func getProfile() async -> ProfileModel?
    
    // Orders
    func saveOrders(_ Orders: OrdersModel) async
    func getOrders() async -> OrdersModel?
}


actor AppStorageImpl: AppStorage {

    // Приватные хранилища для каждого типа данных
    private var collectionStorage: CollectionModelElement?
    private var collectionsStorage: CollectionModel = []
    private var usersStorage: UsersModel = []
    private var userInfoStorage: UserModelElement?
    private var nftsStorage: [String: Nft] = [:]
    private var nftArrayStorage: [NftArrayElement] = []
    private var currenciesArrayStorage: [Currencies] = []
    private var currenciesStorage: Currencies?
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
    // MARK: - User Info

    func saveUserInfo(_ userInfo: UserModelElement) async {
        userInfoStorage = userInfo
    }
    
    func getUsersInfo() async -> UserModelElement? {
        userInfoStorage
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
    func saveCurrencies(_ Currencies: Currencies) async {
        currenciesStorage = Currencies
    }
    
    func getCurrencies() async -> Currencies? {
        currenciesStorage
    }
    
    func saveArrayCurrencies(_ Currencies: [Currencies]) async {
        currenciesArrayStorage = Currencies
    }
    
    func getArrayCurrencies() async -> [Currencies]? {
        currenciesArrayStorage.isEmpty ? nil : currenciesArrayStorage
    }
    // MARK: - Profile
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

