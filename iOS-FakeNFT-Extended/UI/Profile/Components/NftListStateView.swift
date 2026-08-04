//
//  NftListStateView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 04.08.2026.
//

import SwiftUI

/// Общий контейнер экранов со списками NFT: сам показывает загрузку,
/// ошибку и заглушку, а наполнение списка отдаёт вызывающей стороне.
struct NftListStateView<Content: View>: View {

    private let state: NftListState
    private let emptyTextKey: String
    private let content: ([Nft]) -> Content

    init(
        state: NftListState,
        emptyTextKey: String,
        @ViewBuilder content: @escaping ([Nft]) -> Content
    ) {
        self.state = state
        self.emptyTextKey = emptyTextKey
        self.content = content
    }

    var body: some View {
        switch state {
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case let .success(nfts):
            if nfts.isEmpty {
                emptyView
            } else {
                content(nfts)
            }
        case let .error(message):
            Text(message)
                .multilineTextAlignment(.center)
                .padding(16)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private var emptyView: some View {
        Text(NSLocalizedString(emptyTextKey, comment: ""))
            .font(.system(size: 17, weight: .bold))
            .foregroundStyle(Color(.blackPrimary))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
