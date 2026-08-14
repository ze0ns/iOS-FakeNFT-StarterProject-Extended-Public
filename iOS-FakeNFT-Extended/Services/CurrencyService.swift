//
//  CurrencyService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 29.07.2026.
//


import Foundation

protocol CurrenciesService {
    func loadCurrencies() async throws -> [Currencies]
}

@MainActor
final class CurrenciesServiceImpl: CurrenciesService {
    
    private let networkClient: NetworkClient
    private let storage: StorageService
    
    init(networkClient: NetworkClient, storage: StorageService) {
        self.storage = storage
        self.networkClient = networkClient
    }
    
    func loadCurrencies() async throws -> [Currencies] {
        let request = APIRequest.currencies
        let currencies: [Currencies] = try await networkClient.send(request: request)
        await storage.saveArrayCurrencies(currencies)
        return currencies
    }
}
