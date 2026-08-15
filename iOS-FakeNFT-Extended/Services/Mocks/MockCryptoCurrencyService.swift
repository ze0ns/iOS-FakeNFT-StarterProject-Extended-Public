//
//  MockCryptoCurrencyService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/8/14.
//


final class MockCryptoCurrencyService: CryptoCurrencyServiceProtocol {
    var currencies: [CryptoCurrency] = []
    var error: Error?

    init(currencies: [CryptoCurrency] = [], error: Error? = nil) {
        self.currencies = currencies
        self.error = error
    }
    
    func fetchCurrencies() async throws -> [CryptoCurrency] {
        if let error {
            throw error
        }

        return currencies
    }
}
