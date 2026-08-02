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

    private(set) var state: NftListState = .loading
    private(set) var sortOption: NftSortOption

    private var nfts: [Nft] = []

    private let nftIds: [String]
    private let service: MyNftService
    private let defaults: UserDefaults

    init(
        nftIds: [String],
        service: MyNftService,
        defaults: UserDefaults = .standard
    ) {
        self.nftIds = nftIds
        self.service = service
        self.defaults = defaults
        self.sortOption = defaults.string(forKey: Self.sortOptionKey)
            .flatMap(NftSortOption.init(rawValue:)) ?? .default
    }

    func loadNfts() async {
        state = .loading
        do {
            nfts = try await service.loadNfts(ids: nftIds)
            applySort()
        } catch {
            state = .error(message(for: error))
        }
    }

    func setSortOption(_ option: NftSortOption) {
        guard option != sortOption else { return }
        sortOption = option
        defaults.set(option.rawValue, forKey: Self.sortOptionKey)
        applySort()
    }

    private func applySort() {
        state = .success(nfts.sorted(by: sortOption.compare))
    }

    private func message(for error: Error) -> String {
        let key = error is NetworkClientError ? ProfileStrings.networkError : ProfileStrings.unknownError
        return NSLocalizedString(key, comment: "")
    }

    private static let sortOptionKey = "profile.my_nft_sort_option"
}
