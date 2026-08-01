//
//  ProfileServiceImpl.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 30.07.2026.
//


import Foundation

protocol ProfileService {
    func loadProfile() async throws -> ProfileModel
    func updateProfileInfo(profile: ProfileModel) async throws -> ProfileModel
}

@MainActor
final class ProfileServiceImpl: ProfileService {


    
    private let networkClient: NetworkClient
    private let storage: AppStorage

    init(networkClient: NetworkClient, storage: AppStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func loadProfile() async throws -> ProfileModel {
        let request = APIRequest.profile
        let profile: ProfileModel = try await networkClient.send(request: request)
        await storage.saveProfile(profile)
        return profile
    }
    
    func updateProfileInfo(profile: ProfileModel) async throws -> ProfileModel {
        let request = APIRequest.updateProfileInfo(
            likes: profile.likes,
            avatar: profile.avatar,
            name: profile.name,
            description: profile.description
        )
        let profile: ProfileModel = try await networkClient.send(request: request)
        await storage.saveProfile(profile)
        return profile
    }
}
