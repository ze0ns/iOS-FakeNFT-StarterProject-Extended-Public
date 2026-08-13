//
//  PaymentViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/8/11.
//

import Observation

enum PaymentError: Error {
    case currenciesLoadFailed
    case paymentFailed
    case paymentNetworkError
}
@MainActor
@Observable
final class PaymentViewModel {
    
    var paymentError: PaymentError?
    var paymentSucceeded = false
    
    //MARK: - Private properties
    private(set) var items: [CryptoCurrency] = []
    private(set) var isLoadingCurrencies = false
    private(set) var isPaying = false
    private var hasLoadedCurrencies = false
    
    private let currencyService: CryptoCurrencyServiceProtocol
    private let cartService: CartServiceProtocol
    
    //MARK: - Init
    init(currencyService: CryptoCurrencyServiceProtocol,
         cartService: CartServiceProtocol) {
        self.currencyService = currencyService
        self.cartService = cartService
    }
    
    //MARK: - Methods
    func loadItems() async {
        paymentError = nil
        guard !hasLoadedCurrencies else { return }
        
        isLoadingCurrencies = true
        defer { isLoadingCurrencies = false }

        do {
            items = try await currencyService.fetchCurrencies()
            hasLoadedCurrencies = true
        } catch {
            paymentError = .currenciesLoadFailed
        }
    }
    
    func pay(currencyID: String) async {
        paymentSucceeded = false
        paymentError = nil
        isPaying = true
        defer { isPaying = false }

        do {
            let response = try await cartService.pay(currencyID: currencyID)

            if response.success {
                paymentSucceeded = true
            } else {
                paymentError = .paymentFailed
            }
        } catch {
            paymentError = .paymentNetworkError
        }
    }
}
