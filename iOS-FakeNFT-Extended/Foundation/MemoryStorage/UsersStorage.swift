//
//  UsersStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//


import Foundation

protocol UsersStorage: AnyObject {
    func saveCollection(_ usersInfo: UsersModel) async
    func getCollection() async -> UsersModel?
}

// Пример простого актора, который сохраняет данные из сети
actor UsersStorageImpl: UsersStorage {
    private var storage: UsersModel = []
    func saveCollection(_ usersInfo: UsersModel) async {
        storage = usersInfo
    }
    
    func getCollection() async -> UsersModel? {
        storage
    }
    
}
