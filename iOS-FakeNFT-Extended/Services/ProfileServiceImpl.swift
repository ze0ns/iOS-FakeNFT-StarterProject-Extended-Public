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
    func updateLikes(_ likes: [String]) async throws -> ProfileDTO
}

<<<<<<< HEAD
@MainActor
final class ProfileServiceImpl: ProfileService {
    
=======
actor ProfileServiceImpl: ProfileService {

>>>>>>> develop
    private let networkClient: NetworkClient
    private let storage: StorageService
    
    init(networkClient: NetworkClient, storage: StorageService) {
        self.storage = storage
        self.networkClient = networkClient
    }
<<<<<<< HEAD
    
    func loadProfile() async throws -> ProfileModel {
=======

    func loadProfile() async throws -> ProfileDTO {
>>>>>>> develop
        let request = APIRequest.profile
        let profile: ProfileDTO = try await networkClient.send(request: request)
        await storage.saveProfile(profile)
        return profile
    }
    
    /// Отправляет поля, доступные для редактирования: остальные сервер оставляет без изменений.
    func updateProfile(profile: ProfileDTO) async throws -> ProfileDTO {
        var body = FormURLEncodedBody()
        body.append("name", profile.name)
        body.append("description", profile.description)
        body.append("website", profile.website)
        body.append("avatar", profile.avatar)
        return try await update(body: body)
    }

    func updateLikes(_ likes: [String]) async throws -> ProfileDTO {
        var body = FormURLEncodedBody()
        if likes.isEmpty {
            // Пустой список сервер принимает только в таком виде, пустое значение он не понимает
            body.append("likes", "null")
        } else {
            body.append("likes", values: likes)
        }
        return try await update(body: body)
    }

    private func update(body: FormURLEncodedBody) async throws -> ProfileDTO {
        let request = APIRequest.updateProfile(dto: body.text)
        let profile: ProfileDTO = try await networkClient.send(request: request)
        await storage.saveProfile(profile)
        return profile
    }

}
