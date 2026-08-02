//
//  MyNftView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 01.08.2026.
//

import SwiftUI

struct MyNftView: View {

    @State private var viewModel: MyNftViewModel

    @MainActor
    init(nftIds: [String], service: MyNftService) {
        _viewModel = State(initialValue: MyNftViewModel(nftIds: nftIds, service: service))
    }

    var body: some View {
        content
            .navigationTitle(NSLocalizedString(ProfileStrings.myNftTitle, comment: ""))
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.loadNfts()
            }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case let .success(nfts):
            if nfts.isEmpty {
                emptyView
            } else {
                list(for: nfts)
            }
        case let .error(message):
            Text(message)
                .multilineTextAlignment(.center)
                .padding(16)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private func list(for nfts: [Nft]) -> some View {
        List(nfts, id: \.id) { nft in
            MyNftCell(nft: nft)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        }
        .listStyle(.plain)
    }

    private var emptyView: some View {
        Text(NSLocalizedString(ProfileStrings.myNftEmpty, comment: ""))
            .font(.system(size: 17, weight: .bold))
            .foregroundStyle(Color(.blackPrimary))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        MyNftView(nftIds: ["1", "2", "3"], service: MyNftServiceMock())
    }
}
#endif
