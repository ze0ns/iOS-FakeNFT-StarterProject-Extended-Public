//
//  PaymentViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/8/11.
//

import Observation

@MainActor
@Observable
final class PaymentViewModel {
    
    private(set) var items: [CryptoCurrency] = []
    private(set) var isLoading = false
    var showErrorAlert = false
    var paymentSucceeded = false
    
    private let currencyService: CryptoCurrencyServiceProtocol
    
    init(service: CryptoCurrencyServiceProtocol,
         cartService: CartServiceProtocol) {
        self.currencyService = service
    }
    
    func loadItems() async {
        isLoading = true
        defer { isLoading = false }

        do {
            items = try await currencyService.fetchCurrencies()
        } catch {
            items = []
            showErrorAlert = true
        }
    }
    
    // оплата фейковая
    func pay() async {
        do {
            paymentSucceeded = true
        }
    }
}
