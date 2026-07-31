//
//  CartViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/30.
//
import Foundation

enum SortOption: String, CaseIterable {
    case price = "По цене"
    case rating = "По рейтингу"
    case name = "По названию"
}

@MainActor
@Observable
final class CartViewModel {
    
    private(set) var items: [NFTItem] = []
    private(set) var isLoading = false
    var showErrorAlert = false
    
    private let service: CartServiceProtocol

    init(service: CartServiceProtocol) {
        self.service = service
    }
    
    var totalPriceText: String {
        guard let item = items.first else { return "" }
        let totalPrice = items.reduce(Decimal.zero) {$0 + $1.price}
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = ","
        let number = NSDecimalNumber(decimal: totalPrice)
        return "\(formatter.string(from: number) ?? "\(totalPrice)") \(item.currency.rawValue)"
    }
    
    func loadItems() async {
        isLoading = true
        defer { isLoading = false }

        do {
            items = try await service.fetchCartItems()

        } catch {
            items = []
            showErrorAlert = true
        }
    }
    
    func removeItem(_ item: NFTItem) {
        items.removeAll { $0.id == item.id }
    }
    
    func sort(by option: SortOption) {
        switch option {
        case .price:
            items.sort { $0.price < $1.price }

        case .rating:
            items.sort { $0.rating > $1.rating }

        case .name:
            items.sort { $0.name < $1.name }
        }
    }
}
