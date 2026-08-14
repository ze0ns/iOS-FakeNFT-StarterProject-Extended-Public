//
//  CurrencyService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 29.07.2026.
//


import Foundation

<<<<<<< HEAD:iOS-FakeNFT-Extended/Services/CurrencyServiceProtocol.swift
protocol CurrencyService {
    func loadCurrencies() async throws -> [Currency]
}

@MainActor
final class CurrencyServiceImpl: CurrencyService {
    
    private let networkClient: NetworkClient
    private let storage: StorageService
    
    init(networkClient: NetworkClient, storage: StorageService) {
=======
protocol CurrenciesService {
    func loadCourrencies() async throws -> [Currencies]
    func loadCourrenciesByID(id: String) async throws -> Currencies
    func setCurrenciesPay(id: String) async throws -> SetCurrenciesPay
}

@MainActor
final class CurrenciesServiceImpl: CurrenciesService {
    
    private let networkClient: NetworkClient
    private let storage: AppStorage
    
    init(networkClient: NetworkClient, storage: AppStorage) {
>>>>>>> develop:iOS-FakeNFT-Extended/Services/CurrencyService.swift
        self.storage = storage
        self.networkClient = networkClient
    }
    
<<<<<<< HEAD:iOS-FakeNFT-Extended/Services/CurrencyServiceProtocol.swift
    func loadCurrencies() async throws -> [Currency] {
=======
    func loadCourrencies() async throws -> [Currencies] {
>>>>>>> develop:iOS-FakeNFT-Extended/Services/CurrencyService.swift
        let request = APIRequest.currencies
        let currencies: [Currencies] = try await networkClient.send(request: request)
        await storage.saveArrayCurrencies(currencies)
        return currencies
    }
    func loadCourrenciesByID(id: String) async throws -> Currencies {
        let request = APIRequest.currenciesByID(id: id)
        let currencies: Currencies = try await networkClient.send(request: request)
        await storage.saveCurrencies(currencies)
        return currencies
    }
    func setCurrenciesPay(id: String) async throws -> SetCurrenciesPay {
        let request = APIRequest.currenciesSetBeforePay(id: id)
        let responceCurrencies: SetCurrenciesPay = try await networkClient.send(request: request)
        return responceCurrencies
    }
}
