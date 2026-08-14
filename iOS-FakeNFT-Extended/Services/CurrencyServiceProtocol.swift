//
//  CurrencyService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 29.07.2026.
//


import Foundation

protocol CurrencyService {
    func loadCurrencies() async throws -> [Currency]
}

@MainActor
final class CurrencyServiceImpl: CurrencyService {
    
    private let networkClient: NetworkClient
    private let storage: StorageService
    
    init(networkClient: NetworkClient, storage: StorageService) {
        self.storage = storage
        self.networkClient = networkClient
    }
    
    func loadCurrencies() async throws -> [Currency] {
        let request = APIRequest.currencies
        
        do {
            let currencies: [Currency] = try await networkClient.send(request: request)
            print("✅ Данные успешно скачаны из сети")
            await storage.saveCurrency(currencies)
            return currencies
        } catch {
            print("❌ Ошибка при загрузке из сети: \(error.localizedDescription)")
            throw error
        }
    }
}
