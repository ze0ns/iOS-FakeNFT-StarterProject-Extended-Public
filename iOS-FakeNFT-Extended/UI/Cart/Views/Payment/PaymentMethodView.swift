//
//  PaymentMethodView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/8/8.
//
import SwiftUI

enum PaymentError: Error {
    case paymentFailed
}

struct PaymentMethodView: View {
    
    @Environment(CartRouter.self) private var router
    
    @State private var viewModel: PaymentViewModel
    @State private var selectedItem: CryptoCurrency?
    
    private let imageLoader: ImageLoader
    
    init(imageLoader: ImageLoader, viewModel: PaymentViewModel) {
        self.imageLoader = imageLoader
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            grid
            Spacer()
            bottom
        }
        .navigationTitle(Constants.pay)
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
            Constants.error,
            isPresented: $viewModel.showErrorAlert
        ) {
            Button(Constants.cancel, role: .cancel) { }
            Button(Constants.errorRepeat) {
                Task {
                    await viewModel.pay()
                }
            }
        }
    }
    
    private var grid: some View {
        LazyVGrid(columns: [GridItem(.flexible()),
                            GridItem(.flexible())],
                  spacing: 7) {
            ForEach(viewModel.items) { item in
                
                CryptoCurrencyCell(item: item,
                                   imageLoader: imageLoader,
                                   isSelected: selectedItem?.id == item.id)
                .onTapGesture {
                    selectedItem = item
                }
            }
        }
        .padding()
    }
    
    private var bottom: some View {
        VStack {
            webView
            PrimaryButton(title: Constants.pay) {
                Task {
                    await viewModel.pay()
                }
            }
            .padding()
            .disabled(selectedItem == nil)
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
    
    private var webView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(Constants.conditions)
            
            Link(Constants.userAgreement, destination: URL(
                string: Constants.userAgreementURL
            )!)
            .foregroundStyle(.blue)
            .underline(false)
        }
        .font(.system(size: 13))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

private enum Constants {
    static let paymentMethod = NSLocalizedString("PaymentMethod", comment: "")
    static let pay = NSLocalizedString("Pay", comment: "")
    static let userAgreement = NSLocalizedString("UserAgreement", comment: "")
    static let conditions = NSLocalizedString("Conditions", comment: "")
    static let userAgreementURL = "https://practicum.yandex.ru"
    static let error = NSLocalizedString("PaymentError", comment: "")
    static let errorRepeat = NSLocalizedString("Error.repeat", comment: "")
    static let cancel = NSLocalizedString("Cancel", comment: "")
}

#Preview {
    PaymentMethodView(imageLoader: ImageLoader(),
                      viewModel: PaymentViewModel(service: MockCryptoCurrencyService(), cartService: MockCartService()))
    .environment(CartRouter())
}
