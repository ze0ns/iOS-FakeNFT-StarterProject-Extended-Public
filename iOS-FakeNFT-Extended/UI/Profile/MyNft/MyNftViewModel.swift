//
//  MyNftViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 01.08.2026.
//

import Foundation

@Observable
@MainActor
final class MyNftViewModel {

    private(set) var state: MyNftState = .loading

    private let nftIds: [String]
    private let service: MyNftService

    init(nftIds: [String], service: MyNftService) {
        self.nftIds = nftIds
        self.service = service
    }

    func loadNfts() async {
        state = .loading
        do {
            let nfts = try await service.loadNfts(ids: nftIds)
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
