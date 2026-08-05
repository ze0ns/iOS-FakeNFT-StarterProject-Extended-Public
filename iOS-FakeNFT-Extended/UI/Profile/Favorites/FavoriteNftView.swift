//
//  FavoriteNftView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 01.08.2026.
//

import SwiftUI

struct FavoriteNftView: View {

    @State private var viewModel: FavoriteNftViewModel

    @MainActor
    init(likeIds: [String], service: MyNftService) {
        _viewModel = State(initialValue: FavoriteNftViewModel(likeIds: likeIds, service: service))
    }

    var body: some View {
        content
            .navigationTitle(NSLocalizedString(ProfileStrings.favoriteNftTitle, comment: ""))
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.loadNfts()
            }
    }

    private var content: some View {
        NftListStateView(
            state: viewModel.state,
            layout: .grid,
            emptyTextKey: ProfileStrings.favoriteNftEmpty
        ) { nfts in
            grid(for: nfts)
        }
    }

    private func grid(for nfts: [Nft]) -> some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(nfts, id: \.id) { nft in
                    // TODO: удаление из избранного, итерация 3
                    FavoriteNftCellView(nft: nft, onFavoriteTap: {})
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
        }
    }

    private var columns: [GridItem] {
        [
            GridItem(.flexible(), spacing: 7, alignment: .top),
            GridItem(.flexible(), alignment: .top)
        ]
    }

}

#if DEBUG
#Preview {
    NavigationStack {
        FavoriteNftView(likeIds: ["1", "2", "3"], service: MyNftServiceMock())
    }
}
#endif
