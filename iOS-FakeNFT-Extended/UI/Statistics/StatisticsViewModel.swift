//
//  StatisticsViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 15.08.2026.
//


import Foundation
import SwiftUI

@MainActor
final class StatisticsViewModel: ObservableObject {
    // Публикуем массив данных, за изменением которого будет следить View
    @Published var nfts: [Nft] = []
    @Published var isLoading: Bool = false
    
    init() {
        fetchNfts()
    }
    
    func fetchNfts() {
        isLoading = true
        
        // Симуляция асинхронного запроса (например, вызов сетевого слоя)
        Task {
            try? await Task.sleep(for: .seconds(1))
            
            // Здесь вы получите реальные данные из API или БД
            self.nfts = [
                Nft(
                    id: "1464520d-1659-4055-8a79-4593b9569e48",
                    name: "Lilo",
                    images: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Yellow/Helga/1.png")!],
                    rating: 3,
                    price: 1.78,
                    author: "John Doe"
                ),
                Nft(
                    id: "2764520d-1659-4055-8a79-4593b9569e49",
                    name: "Stitch",
                    images: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Yellow/Helga/2.png")!],
                    rating: 5,
                    price: 2.45,
                    author: "Jane Smith"
                )
               
            ]
            
            self.isLoading = false
        }
    }
    
    // Обработка бизнес-логики при клике на кнопку
    func toggleFavorite(for nft: Nft) {
        // Отправка запроса на сервер или обновление локальной БД
        print("Favorite tapped on: \(nft.name)")
    }
}
