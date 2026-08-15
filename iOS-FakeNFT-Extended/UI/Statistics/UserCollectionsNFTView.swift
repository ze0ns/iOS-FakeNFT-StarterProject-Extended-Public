//
//  StatisticsView 2.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 15.08.2026.
//


import SwiftUI

struct UserCollectionsNFTView: View {
    // Используем @StateObject, так как View является владельцем этой ViewModel
    @StateObject private var viewModel = StatisticsViewModel()
    
    // Настройка адаптивной сетки
    private let columns = [
        GridItem(.adaptive(minimum: 108), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 200)
            } else {
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
        .navigationTitle("Коллекция")
    }
}

#Preview {
    NavigationStack {
        UserCollectionsNFTView()
    }
}
