import Foundation

protocol ProfileService: Sendable {
    func loadProfile(id: String) async throws -> Profile
    func invalidateCache() async
}

extension ProfileService {
    func loadProfile() async throws -> Profile {
        try await loadProfile(id: ProfileServiceImpl.currentProfileId)
    }
}

actor ProfileServiceImpl: ProfileService {

    static let currentProfileId = "1"

    private let networkClient: NetworkClient
    private var cachedProfile: Profile?

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func loadProfile(id: String) async throws -> Profile {
        if let cachedProfile, cachedProfile.id == id {
            return cachedProfile
        }

        let request = ProfileRequest(id: id)
        let profile: Profile = try await networkClient.send(request: request)
        cachedProfile = profile
        return profile
    }

    func invalidateCache() {
        cachedProfile = nil
    }
}
