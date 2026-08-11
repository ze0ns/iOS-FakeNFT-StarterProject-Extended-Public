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
    
    private let service: CryptoCurrencyServiceProtocol

    init(service: CryptoCurrencyServiceProtocol) {
        self.service = service
    }
    
    func loadItems() async {
        isLoading = true
        defer { isLoading = false }

        do {
            items = try await service.fetchCurrencies()
        } catch {
            items = []
            showErrorAlert = true
        }
    }
    
    func pay() {
           // paymentSucceeded = true
        showErrorAlert = true
        }
}
