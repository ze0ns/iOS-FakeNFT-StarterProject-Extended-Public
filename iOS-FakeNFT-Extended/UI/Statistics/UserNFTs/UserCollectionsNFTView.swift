//
//  UserCollectionsNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 15.08.2026.
//

import SwiftUI

struct UserCollectionsNFTView: View {
    
    @StateObject private var viewModel: UserNFTsViewModel
    
    init(
        likeIds: [String],
        service: MyNftService,
        profileService: ProfileService,
        onProfileUpdated: @escaping (ProfileDTO) -> Void
    ) {
        _viewModel = StateObject(
            wrappedValue: UserNFTsViewModel(
                likeIds: likeIds,
                service: service,
                profileService: profileService,
                onProfileUpdated: onProfileUpdated
            )
        )
    }
    
    private let columns = [GridItem(.adaptive(minimum: 108), spacing: 16)]
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 200)
            case .error(let message):
                errorView(message)
            case .empty:
                emptyStateView
            case .loaded(let nfts):
                nftListView(nfts)
            }
        }
        .navigationTitle("Коллекция")
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    // MARK: - Subviews
    
    private func nftListView(_ nfts: [Nft]) -> some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(nfts) { nft in
                    StatisticsNftCellView(
                        nft: nft,
                        isLiked: viewModel.likeIds.contains(nft.id), // Проверяем, есть ли NFT в массиве лайков
                        onFavoriteTap: {
                            viewModel.toggleFavorite(for: nft)
                        },
                        onCartTap: {
                            // Логика корзины
                        }
                    )
                }
            }
            .padding(16)
        }
        .refreshable {
            await viewModel.loadNfts()
        }
    }
    
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            Text(message)
                .multilineTextAlignment(.center)
            Button("Повторить") {
                Task { await viewModel.loadNfts() }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 8) {
            Image(systemName: "heart.slash")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            Text("Нет избранных NFT")
                .font(.headline)
        }
    }
}
#Preview {
    NavigationStack {
        UserCollectionsNFTView(likeIds: ["1", "2", "3"],
                               service: MyNftServicePreviewStub(),
                               profileService: ProfileServicePreviewStub(),
                               onProfileUpdated: { _ in })
    }
}
