//
//  CartFlowView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/8/11.
//
import SwiftUI

struct CartFlowView: View {
    
    @State private var router = CartRouter()
    @State private var cartViewModel: CartViewModel
    @State private var paymentViewModel: PaymentViewModel
    
    private let imageLoader: ImageLoader
    
    init(
        cartService: CartServiceProtocol,
        currencyService: CryptoCurrencyServiceProtocol,
        imageLoader: ImageLoader
    ) {
        _cartViewModel = State(
            initialValue: CartViewModel(service: cartService)
        )
        
        _paymentViewModel = State(
            initialValue: PaymentViewModel(
                currencyService: currencyService,
                cartService: cartService
            )
        )
        
        self.imageLoader = imageLoader
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            CartView(
                viewModel: cartViewModel,
                imageLoader: imageLoader
            )
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .payment:
                    PaymentMethodView(
                        imageLoader: imageLoader,
                        viewModel: paymentViewModel
                    )
                    
                case .success:
                    SuccessPaymentView()
                }
            }
        }
        .environment(router)
    }
}
