//
//  CartFlowView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/8/11.
//
import SwiftUI

struct CartFlowView: View {
    
    @State private var router = CartRouter()
    
    private let cartViewModel: CartViewModel
    private let paymentViewModel: PaymentViewModel
    private let imageLoader: ImageLoader
    
    // MARK: - Init
    init(cartViewModel: CartViewModel, paymentViewModel: PaymentViewModel, imageLoader: ImageLoader) {
        self.cartViewModel = cartViewModel
        self.paymentViewModel = paymentViewModel
        self.imageLoader = imageLoader
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack(path: $router.path) {
            CartView(viewModel: cartViewModel, imageLoader: imageLoader)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .payment:
                        PaymentMethodView(imageLoader: imageLoader, viewModel: paymentViewModel)
                    case .success:
                        SuccessPaymentView()
                    }
                }
        }
        .environment(router)
    }
}
