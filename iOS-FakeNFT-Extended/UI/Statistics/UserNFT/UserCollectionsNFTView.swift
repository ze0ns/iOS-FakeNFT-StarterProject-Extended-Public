//
//  UserCollectionsNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 15.08.2026.
//

import SwiftUI

struct UserCollectionsNFTView: View {
    
    // @StateObject — View является владельцем ViewModel
    @StateObject private var viewModel: UserNFTsViewModel
    
    // Инициализатор с правильной обёрткой StateObject
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
    
    // Настройка адаптивной сетки
    private let columns = [
        GridItem(.adaptive(minimum: 108), spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            if viewModel.isLoading && viewModel.nfts.isEmpty {
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 200)
            } else if let error = viewModel.errorMessage {
                errorView(error)
            } else if viewModel.nfts.isEmpty {
                emptyStateView
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.nfts) { nft in
                            StatisticsNftCellView(
                                nft: nft,
                                onFavoriteTap: {
                                    viewModel.toggleFavorite(for: nft)
                                }
                            )
                        }
                    }
                    .padding(16)
                }
            }
        }
        .navigationTitle("Коллекция")
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    // MARK: - Subviews
    
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
