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
    private var hasLoadedCurrencies = false
    
    var showErrorAlert = false
    var paymentSucceeded = false
    
    private let currencyService: CryptoCurrencyServiceProtocol
    private let cartService: CartServiceProtocol
    
    init(currencyService: CryptoCurrencyServiceProtocol,
         cartService: CartServiceProtocol) {
        self.currencyService = currencyService
        self.cartService = cartService
    }
    
    func loadItems() async {
        guard !hasLoadedCurrencies else { return }
        
        isLoading = true
        defer { isLoading = false }

        do {
            items = try await currencyService.fetchCurrencies()
            hasLoadedCurrencies = true
        } catch {
            showErrorAlert = true
        }
    }
    
    func pay(currencyID: String) async {
        
        isLoading = true
        defer { isLoading = false }
        
                do {
                    let response = try await cartService.pay(
                        currencyID: currencyID
                    )
                    if response.success {
                        paymentSucceeded = true
                    }
                } catch {
                    showErrorAlert = true
                }
            }
}
