//
//  PaymentViewModelTests.swift
//  iOS-FakeNFT-ExtendedTests
//
//  Created by Svetlana on 2026/8/14.
//

import XCTest
@testable import iOS_FakeNFT_Extended

@MainActor
final class PaymentViewModelTests: XCTestCase {
    
    private var currencyService: MockCryptoCurrencyService!
    private var cartService: MockCartService!
    private var viewModel: PaymentViewModel!

    private let currencyID = "BTC"
    private let paymentResponse = PaymentResponse(
        success: true,
        orderId: "1",
        id: "1"
    )
    
    override func setUp() {
        super.setUp()
        
        currencyService = MockCryptoCurrencyService()
        cartService = MockCartService()
        
        viewModel = PaymentViewModel(
            currencyService: currencyService,
            cartService: cartService
        )
    }

    override func tearDown() {
        viewModel = nil
        currencyService = nil
        cartService = nil
        
        super.tearDown()
    }
    
    func testPay_whenResponseIsNotSuccessful_setsPaymentFailed() async {
        // Given
        cartService.paymentResponse = paymentResponse

        // When
        await viewModel.pay(currencyID: currencyID)

        // Then
        XCTAssertEqual(viewModel.paymentError, .paymentFailed)
        XCTAssertFalse(viewModel.paymentSucceeded)
    }
    
    func testPay_whenNetworkErrorOccurs_setsPaymentNetworkError() async {
        // Given
        cartService.networkError = .paymentNetworkError

        // When
        await viewModel.pay(currencyID: currencyID)

        // Then
        XCTAssertEqual(viewModel.paymentError, .paymentNetworkError)
        XCTAssertFalse(viewModel.paymentSucceeded)
    }
    
    @MainActor
    func testPay_whenPaymentIsSuccessful_setsPaymentSucceeded() async {
        // Given
        cartService.paymentResponse = paymentResponse

        // When
        await viewModel.pay(currencyID: currencyID)

        // Then
        XCTAssertTrue(viewModel.paymentSucceeded)
        XCTAssertNil(viewModel.paymentError)
    }
    
}
