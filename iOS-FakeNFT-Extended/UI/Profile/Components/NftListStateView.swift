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

    /// Форма скелетона на время загрузки: таблица «Мои NFT» или сетка «Избранные NFT».
    enum Layout {
        case list
        case grid
    }

    private static var skeletonCount: Int { 6 }
    private static var skeletonDelayStep: TimeInterval { 0.1 }

    private let state: NftListState
    private let layout: Layout
    private let emptyTextKey: String
    private let content: ([Nft]) -> Content

    init(
        state: NftListState,
        layout: Layout,
        emptyTextKey: String,
        @ViewBuilder content: @escaping ([Nft]) -> Content
    ) {
        self.state = state
        self.layout = layout
        self.emptyTextKey = emptyTextKey
        self.content = content
    }

    var body: some View {
        switch state {
        case .loading:
            loadingView
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

    @ViewBuilder
    private var loadingView: some View {
        switch layout {
        case .list:
            listSkeleton
        case .grid:
            gridSkeleton
        }
    }

    private var listSkeleton: some View {
        List(0 ..< Self.skeletonCount, id: \.self) { index in
            HStack(spacing: 20) {
                skeleton(at: index)
                    .frame(width: 108, height: 108)
                    .clipShape(.rect(cornerRadius: 12))

                textLinesSkeleton(at: index, widths: [110, 80, 95])

                Spacer(minLength: 0)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 39))
        }
        .listStyle(.plain)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(NSLocalizedString(ProfileStrings.loadingAccessibility, comment: ""))
    }

    private var gridSkeleton: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0 ..< Self.skeletonCount, id: \.self) { index in
                    HStack(spacing: 12) {
                        skeleton(at: index)
                            .frame(width: 80, height: 80)
                            .clipShape(.rect(cornerRadius: 12))

                        textLinesSkeleton(at: index, widths: [70, 60, 55])

                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(NSLocalizedString(ProfileStrings.loadingAccessibility, comment: ""))
    }

    private var columns: [GridItem] {
        [
            GridItem(.flexible(), spacing: 7, alignment: .top),
            GridItem(.flexible(), alignment: .top)
        ]
    }

    private func skeleton(at index: Int) -> Skeleton {
        Skeleton(delay: Double(index) * Self.skeletonDelayStep)
    }

    private func textLinesSkeleton(at index: Int, widths: [CGFloat]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(Array(widths.enumerated()), id: \.offset) { _, width in
                skeleton(at: index)
                    .frame(width: width, height: 14)
                    .clipShape(.rect(cornerRadius: 4))
            }
        }
    }

    private var emptyView: some View {
        Text(NSLocalizedString(emptyTextKey, comment: ""))
            .font(.system(size: 17, weight: .bold))
            .foregroundStyle(Color(.blackPrimary))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
