//
//  ProfileServicePreviewStub.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 28.07.2026.
//

import Foundation

#if DEBUG
/// Сервис профиля для превью: отдаёт заготовленные данные без сети.
actor ProfileServicePreviewStub: ProfileService {

    func loadProfile() async throws -> ProfileDTO {
        ProfileDTO.preview
    }

    func updateProfile(profile: ProfileDTO) async throws -> ProfileDTO {
        profile
    }

    func updateLikes(_ likes: [String]) async throws -> ProfileDTO {
        ProfileDTO.preview
    }
}
#endif
