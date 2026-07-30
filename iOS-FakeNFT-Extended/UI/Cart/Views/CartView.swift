//
//  CartView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/29.
//
import SwiftUI

struct CartView: View {
    
    @State private var items: [NFTItem] = []
    @State private var isLoading = false
    
    private let service: CartServiceProtocol
    
    init(service: CartServiceProtocol = MockCartService()) {
        self.service = service
    }
    
    private var totalPrice: Decimal {
        items.reduce(0) { $0 + $1.price }
    }
    
    private var totalPriceText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = ","
        let number = NSDecimalNumber(decimal: totalPrice)
        guard let item = items.first else { return "" }
        return "\(formatter.string(from: number) ?? "\(totalPrice)") \(item.currency.rawValue)"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if isLoading {
                ProgressView()
            } else if items.isEmpty {
                emptyStateView
            } else {
                ScrollView {
                    filterButton
                    VStack(spacing: 20) {
                        ForEach(items) { item in
                            CartCell(item: item) {
                                items.removeAll { $0.id == item.id }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                bottomBar
            }
        }
        .background(Color(.whitePrimary))
        .task {
                    await loadItems()
                }
    }
    
    // MARK: Header
    
    private var filterButton: some View {
        HStack {
            Spacer()
            Image(.filterButton)
                .frame(width: 42, height: 42)
        }
        .padding(.horizontal, 9)
        .padding(.bottom, 20)
    }
    
    // MARK: Bottom bar
    
    private var bottomBar: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(items.count) NFT")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                    
                    Text(totalPriceText)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.greenUniversal)
                }
                
                Spacer()
                
                PrimaryButton(title: Constants.pay,
                              isEnabled: true) {
                    
                }
                .frame(width: 240, height: 44)
                
            }
            .padding()
            .background(.lightGrayPrimary)
        }
    }
    
    private var emptyStateView: some View {
        VStack {
            Spacer()
            Text(Constants.emptyCart)
                .font(.system(size: 17))
                .foregroundColor(.blackPrimary)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: Loading
    private func loadItems() async {
            isLoading = true
            defer { isLoading = false }
     
            do {
                items = try await service.fetchCartItems()
            } catch {
                items = []
                // здесь можно завести @State private var errorMessage: String?
                // и показать алерт/баннер с ошибкой
            }
        }
}

private enum Constants {
    static let pay = NSLocalizedString("Pay", comment: "")
    static let emptyCart = NSLocalizedString("EmptyCart", comment: "")
}

 

// MARK: - Preview

#Preview {
    CartView(service: MockCartService())
}

#Preview {
    CartView(service: MockCartService())
}
