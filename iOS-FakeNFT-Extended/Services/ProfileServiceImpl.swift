//
//  ProfileServiceImpl.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 30.07.2026.
//


import Foundation

protocol ProfileService: Sendable {
    func loadProfile() async throws -> ProfileDTO
    func updateProfile(profile: ProfileDTO) async throws -> ProfileDTO
}

actor ProfileServiceImpl: ProfileService {

    private let networkClient: NetworkClient
    private let storage: AppStorage

    init(networkClient: NetworkClient, storage: AppStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func loadProfile() async throws -> ProfileDTO {
        let request = APIRequest.profile
        let profile: ProfileDTO = try await networkClient.send(request: request)
        await storage.saveProfile(profile)
        return profile
    }
    
    func updateProfile(profile: ProfileDTO) async throws -> ProfileDTO {
        let request = APIRequest.updateProfile(dto: profile)
        let profile: ProfileDTO = try await networkClient.send(request: request)
        await storage.saveProfile(profile)
        return profile
    }
    
}
