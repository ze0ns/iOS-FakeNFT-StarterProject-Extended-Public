//
//  MyNftView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 01.08.2026.
//

import SwiftUI

struct MyNftView: View {

    @State private var viewModel: MyNftViewModel
    @State private var isSortDialogPresented = false

    @MainActor
    init(nftIds: [String], service: MyNftService) {
        _viewModel = State(initialValue: MyNftViewModel(nftIds: nftIds, service: service))
    }

    var body: some View {
        content
            .navigationTitle(NSLocalizedString(ProfileStrings.myNftTitle, comment: ""))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    sortButton
                }
            }
            .confirmationDialog(
                NSLocalizedString(ProfileStrings.sortTitle, comment: ""),
                isPresented: $isSortDialogPresented,
                titleVisibility: .visible
            ) {
                sortDialogButtons
            }
            .task {
                await viewModel.loadNfts()
            }
    }

    private var content: some View {
        NftListStateView(
            state: viewModel.state,
            emptyTextKey: ProfileStrings.myNftEmpty
        ) { nfts in
            list(for: nfts)
        }
    }

    private var sortButton: some View {
        Button {
            isSortDialogPresented = true
        } label: {
            Image(systemName: ProfileIcons.sort)
                .foregroundStyle(Color(.blackPrimary))
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var sortDialogButtons: some View {
        ForEach(NftSortOption.allCases, id: \.self) { option in
            Button(title(for: option)) {
                viewModel.setSortOption(option)
            }
        }

        // Роль cancel не указана: система прячет такую кнопку, когда показывает диалог поповером
        Button(NSLocalizedString(ProfileStrings.close, comment: "")) {}
    }

    /// Помечает выбранный вариант: кнопки диалога умеют показывать только текст.
    private func title(for option: NftSortOption) -> String {
        let title = NSLocalizedString(option.titleKey, comment: "")
        guard option == viewModel.sortOption else { return title }

        return String(
            format: NSLocalizedString(ProfileStrings.sortSelectedFormat, comment: ""),
            title
        )
    }

    private func list(for nfts: [Nft]) -> some View {
        List(nfts, id: \.id) { nft in
            MyNftCell(nft: nft)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        }
        .listStyle(.plain)
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        MyNftView(nftIds: ["1", "2", "3"], service: MyNftServiceMock())
    }
}
#endif
