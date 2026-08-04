//
//  CollectionService 2.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//


//
//  CollectionService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//  Получение коллекций NFT


import Foundation

protocol UsersInfoService {
    func loadUsersInfo(page: String) async throws -> UsersModel
}

@MainActor
final class UsersInfoServiceImpl: UsersInfoService {

    private let networkClient: NetworkClient
    private let storage: StorageService

    init(networkClient: NetworkClient, storage: StorageService) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func loadUsersInfo(page: String) async throws -> UsersModel {
        let request = APIRequest.users(page: page)
        
        do {
            let users: UsersModel = try await networkClient.send(request: request)
            print("✅ Данные успешно скачаны из сети")
            await storage.saveUsers(users)
            return users
        } catch {
            print("❌ Ошибка при загрузке из сети: \(error.localizedDescription)")
            throw error
        }
    }
}
