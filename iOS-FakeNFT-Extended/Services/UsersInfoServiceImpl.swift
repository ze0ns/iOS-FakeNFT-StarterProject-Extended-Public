//  CollectionService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//  Получение коллекций NFT


import Foundation

protocol UsersInfoService {
    func loadUsersInfo(page: String) async throws -> UsersModel
    func loadUserInfoById(id: String) async throws -> UserModelElement
}

@MainActor
final class UsersInfoServiceImpl: UsersInfoService {
    
    private let networkClient: NetworkClient
    private let storage: AppStorage
    
    init(networkClient: NetworkClient, storage: AppStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }
    
    func loadUsersInfo(page: String) async throws -> UsersModel {
        let request = APIRequest.users(page: page)
        let users: UsersModel = try await networkClient.send(request: request)
        await storage.saveUsers(users)
        return users
    }
    func loadUserInfoById(id: String) async throws -> UserModelElement {
        let request = APIRequest.userInfoByID(id: id)
        let userInfo: UserModelElement = try await networkClient.send(request: request)
        await storage.saveUserInfo(userInfo)
        return userInfo
    }
}
