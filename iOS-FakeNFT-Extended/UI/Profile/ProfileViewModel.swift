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

    enum State {
        case loading
        case loaded(ProfileModel)
        case failed(String)
    }

    private(set) var state: State = .loading

    private let profileService: ProfileService

    init(profileService: ProfileService) {
        self.profileService = profileService
    }

    func loadProfile() async {
        state = .loading
        do {
            let profile = try await profileService.loadProfile()
            state = .loaded(profile)
        } catch {
            state = .failed(message(for: error))
        }
    }

    private func message(for error: Error) -> String {
        let key = error is NetworkClientError ? "Error.network" : "Error.unknown"
        return NSLocalizedString(key, comment: "")
    }
}
