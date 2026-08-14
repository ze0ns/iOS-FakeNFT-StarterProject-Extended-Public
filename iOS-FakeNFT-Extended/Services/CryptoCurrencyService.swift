//
//  CryptoCurrencyService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/8/11.
//
import Foundation

protocol CryptoCurrencyServiceProtocol {
    func fetchCurrencies() async throws -> [CryptoCurrency]
}

final class CryptoCurrencyService: CryptoCurrencyServiceProtocol {
    
    private let currencyService: CurrencyService
    
    init(currencyService: CurrencyService) {
        self.currencyService = currencyService
    }
    
    func fetchCurrencies() async throws -> [CryptoCurrency] {
        let currencies = try await currencyService.loadCurrencies()
        
        
        return currencies
            .map { currency in
                return CryptoCurrency(title: currency.title,
                                      name: currency.name,
                                      imageURL:  URL(string: currency.image),
                                      id: currency.id)
                
        }
    }
    
}

