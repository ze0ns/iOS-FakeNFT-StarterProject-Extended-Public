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
    @State private var showErrorAlert = false
    
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
                list
                bottomBar
            }
        }
        .alert(Constants.failed, isPresented: $showErrorAlert) {
            Button(Constants.cancel, role: .cancel) { }
            Button(Constants.errorRepeat) {
                Task {
                    await loadItems()
                }
            }
        }
        .background(Color(.whitePrimary))
        .task {
            await loadItems()
        }
    }
    
    // MARK: List
    private var list: some View {
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
    }
    
    // MARK: - Header
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
    
    // MARK: - EmptyStateView
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
    
    // MARK: - Loading
    private func loadItems() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            items = try await service.fetchCartItems()
        } catch {
            items = []
            showErrorAlert = true
        }
    }
}

private enum Constants {
    static let pay = NSLocalizedString("Pay", comment: "")
    static let emptyCart = NSLocalizedString("EmptyCart", comment: "")
    static let failed = NSLocalizedString("Error.network", comment: "")
    static let errorRepeat = NSLocalizedString("Error.repeat", comment: "")
    static let cancel = NSLocalizedString("Cancel", comment: "")
}

// MARK: - Preview
#Preview {
    CartView(service: MockCartService())
}

#Preview {
    CartView(service: FailingCartService())
}
