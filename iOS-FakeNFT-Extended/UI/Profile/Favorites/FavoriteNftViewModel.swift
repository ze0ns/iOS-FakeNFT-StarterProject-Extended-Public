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

    private let likeIds: [String]
    private let service: MyNftService

    init(likeIds: [String], service: MyNftService) {
        self.likeIds = likeIds
        self.service = service
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

    private func message(for error: Error) -> String {
        let key = error is NetworkClientError ? ProfileStrings.networkError : ProfileStrings.unknownError
        return NSLocalizedString(key, comment: "")
    }
}
