//
//  PaymentMethodView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/8/8.
//
import SwiftUI

struct PaymentMethodView: View {
    
    @Environment(CartRouter.self) private var router
    
    @State private var viewModel: PaymentViewModel
    @State private var selectedCurrency: CryptoCurrency?
    @State private var showWebView = false
    
    private let imageLoader: ImageLoader
    
    private var paymentErrorTitle: String {
        switch viewModel.paymentError {
        case .paymentFailed:
            Constants.paymentError
        case .currenciesLoadFailed, .paymentNetworkError:
            Constants.networkError
        case nil:
            ""
        }
    }
    
    // MARK: - Init
    init(imageLoader: ImageLoader, viewModel: PaymentViewModel) {
        self.imageLoader = imageLoader
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack {
                grid
                Spacer()
                bottom
            }
            
            if viewModel.isLoadingCurrencies || viewModel.isPaying {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle(Constants.paymentMethod)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadItems()
        }
        .onChange(of: viewModel.paymentSucceeded) { _, success in
            if success {
                router.openSuccess()
            }
        }
        .alert(
            paymentErrorTitle,
            isPresented: Binding(
                get: { viewModel.paymentError != nil },
                set: { isPresented in
                    if !isPresented {
                        viewModel.paymentError = nil
                    }
                }
            )
        ) {
            Button(Constants.cancel, role: .cancel) {
                viewModel.paymentError = nil
            }
            
            Button(Constants.errorRepeat) {
                switch viewModel.paymentError {
                case .currenciesLoadFailed:
                    reloadCurrencies()
                case .paymentFailed, .paymentNetworkError:
                    pay()
                case nil:
                    break
                }
            }
        }
    }
    
    // MARK: - Grid
    private var grid: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ],
                  spacing: 7
        ) {
            ForEach(viewModel.items) { item in
                Button {
                    selectedCurrency = item
                } label: {
                    CryptoCurrencyCell(
                        item: item,
                        imageLoader: imageLoader,
                        isSelected: selectedCurrency?.id == item.id
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
    }
    
    // MARK: - Bottom
    private var bottom: some View {
        VStack {
            agreementView
            PrimaryButton(title: Constants.pay) {
                pay()
            }
            .padding()
            .disabled(selectedCurrency == nil)
        }
        .background(Color.lightGrayPrimary
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 12,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 12
                )
            )
                .ignoresSafeArea(edges: .bottom))
    }
    
    // MARK: - Agreement View
    private var agreementView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(Constants.conditions)
            
            Button(Constants.userAgreement) {
                showWebView = true
            }
            .foregroundStyle(.blue)
            .underline(false)
        }
        .font(.system(size: 13))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .sheet(isPresented: $showWebView) {
            if let url = URL(string: Constants.userAgreementURL) {
                WebView(url: url)
            }
        }
    }
    
    // MARK: - Methods
    private func pay() {
        guard let id = selectedCurrency?.id else { return }
        
        Task {
            await viewModel.pay(currencyID: id)
        }
    }
    
    private func reloadCurrencies() {
        Task {
            await viewModel.loadItems()
        }
    }
    
}
// MARK: - Constants
private enum Constants {
    static let paymentMethod = NSLocalizedString("PaymentMethod", comment: "")
    static let pay = NSLocalizedString("Pay", comment: "")
    static let userAgreement = NSLocalizedString("UserAgreement", comment: "")
    static let conditions = NSLocalizedString("PaymentConditions", comment: "")
    static let paymentError = NSLocalizedString("PaymentError", comment: "")
    static let networkError = NSLocalizedString("Error.network", comment: "")
    static let errorRepeat = NSLocalizedString("Error.repeat", comment: "")
    static let cancel = NSLocalizedString("Cancel", comment: "")
    
    static let userAgreementURL = "https://yandex.ru/legal/practicum_termsofuse"
}

// MARK: - Preview
#Preview {
    PaymentMethodView(imageLoader: ImageLoader(),
                      viewModel: PaymentViewModel(currencyService: MockCryptoCurrencyService(), cartService: MockCartService()))
    .environment(CartRouter())
}
