//
//  ProfileViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 28.07.2026.
//

import Foundation

@Observable
@MainActor
final class ProfileViewModel {

    private(set) var state: ProfileState = .loading

    /// Загруженный профиль, если он уже пришёл с сервера.
    var profile: ProfileDTO? {
        guard case let .success(profile) = state else { return nil }
        return profile
    }

    private let profileService: ProfileService

    init(profileService: ProfileService) {
        self.profileService = profileService
    }

    func loadProfile() async {
        state = .loading
        do {
            let profile = try await profileService.loadProfile()
            state = .success(profile)
        } catch {
            state = .error(ProfileErrorMessage.text(for: error))
        }
    }

    /// Показывает профиль, изменённый на другом экране, без повторного запроса.
    func apply(_ profile: ProfileDTO) {
        state = .success(profile)
    }
}
