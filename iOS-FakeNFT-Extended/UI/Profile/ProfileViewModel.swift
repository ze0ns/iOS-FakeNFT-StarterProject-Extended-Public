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
            state = .error(message(for: error))
        }
    }

    private func message(for error: Error) -> String {
        let key = error is NetworkClientError ? ProfileStrings.networkError : ProfileStrings.unknownError
        return NSLocalizedString(key, comment: "")
    }
}
