//
//  ProfileServiceImpl.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 30.07.2026.
//


import Foundation

protocol ProfileService {
    func loadProfile() async throws -> ProfileModel
    func updateProfile(profile: ProfileModel) async throws -> ProfileModel
}

@MainActor
final class ProfileServiceImpl: ProfileService {
    
    private let networkClient: NetworkClient
    private let storage: StorageService
    
    init(networkClient: NetworkClient, storage: StorageService) {
        self.storage = storage
        self.networkClient = networkClient
    }
    
    func loadProfile() async throws -> ProfileModel {
        let request = APIRequest.profile
        let profile: ProfileModel = try await networkClient.send(request: request)
        await storage.saveProfile(profile)
        return profile
    }
    
    func updateProfile(profile: ProfileModel) async throws -> ProfileModel {
        let request = APIRequest.updateProfile(dto: profile)
        let profile: ProfileModel = try await networkClient.send(request: request)
        await storage.saveProfile(profile)
        return profile
    }
    
}
