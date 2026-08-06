//
//  FavoriteNftViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 01.08.2026.
//

import Foundation

@Observable
@MainActor
final class FavoriteNftViewModel {

    private(set) var state: NftListState = .loading
    private(set) var errorMessage: String?
    private(set) var isRemoving = false

    private var likeIds: [String]
    private let service: MyNftService
    private let profileService: ProfileService
    private let onProfileUpdated: (ProfileDTO) -> Void

    init(
        likeIds: [String],
        service: MyNftService,
        profileService: ProfileService,
        onProfileUpdated: @escaping (ProfileDTO) -> Void
    ) {
        self.likeIds = likeIds
        self.service = service
        self.profileService = profileService
        self.onProfileUpdated = onProfileUpdated
    }

    func loadNfts() async {
        state = .loading
        do {
            let nfts = try await service.loadNfts(ids: likeIds)
            state = .success(nfts)
        } catch {
            state = .error(message(for: error))
        }
    }

    /// Убирает NFT из избранного на сервере и из списка на экране.
    /// Пока запрос не завершился, соседние нажатия пропускаются: иначе они отправят устаревший список.
    func removeFromFavorites(id: String) async {
        guard case let .success(nfts) = state, !isRemoving else { return }

        isRemoving = true
        defer { isRemoving = false }

        do {
            let profile = try await profileService.updateLikes(likeIds.filter { $0 != id })
            likeIds = profile.likes
            state = .success(nfts.filter { $0.id != id })
            onProfileUpdated(profile)
        } catch {
            // Список остаётся прежним: сервер не принял изменение
            errorMessage = message(for: error)
        }
    }

    func dismissError() {
        errorMessage = nil
    }

    private func message(for error: Error) -> String {
        let key = error is NetworkClientError ? ProfileStrings.networkError : ProfileStrings.unknownError
        return NSLocalizedString(key, comment: "")
    }
}
