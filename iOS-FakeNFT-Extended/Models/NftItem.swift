//
//  NftItem.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/27.
//
import Foundation

struct NFTItem: Identifiable {
    let id: String
    let name: String
    let imageName: String
    let rating: Int
    let price: Decimal
    let currency: CryptoCurrency
    let sellerName: String?
    
    private static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = ","
        return formatter
    }()
    
    var formattedPrice: String {
        let number = NSDecimalNumber(decimal: price)
        return "\(Self.priceFormatter.string(from: number) ?? "\(price)") \(currency.rawValue)"
    }
}

extension NFTItem {
    
    static let mockVulcan = NFTItem(id: "mockVulcan",
                                    name: "Vulcan",
                                    imageName: "vulcan",
                                    rating: 2,
                                    price: 1.78,
                                    currency: .eth,
                                    sellerName: "John Doe")
    
    static let mockHelga = NFTItem(id: "mockHelga",
                                   name: "Helga",
                                   imageName: "helga",
                                   rating: 5,
                                   price: 1.22,
                                   currency: .eth,
                                   sellerName: "John Doe")
    
    static let mockFlorine = NFTItem(id: "mockFlorine",
                                     name: "Florine",
                                     imageName: "florine",
                                     rating: 4,
                                     price: 1.65,
                                     currency: .eth,
                                     sellerName: "John Doe")
    
    static let mockOlaf = NFTItem(id: "mockOlaf",
                                  name: "Olaf",
                                  imageName: "olaf",
                                  rating: 2,
                                  price: 1.78,
                                  currency: .eth,
                                  sellerName: "John Doe")
    
    static let mockWillow = NFTItem(id: "mockOlaf",
                                    name: "Willow",
                                    imageName: "willow",
                                    rating: 5,
                                    price: 1.22,
                                    currency: .eth,
                                    sellerName: "John Doe")
    
    static let mockPumpkin = NFTItem(id: "mockOlaf",
                                     name: "Pumpkin",
                                     imageName: "pumpkin",
                                     rating: 4,
                                     price: 1.65,
                                     currency: .eth,
                                     sellerName: "John Doe")
    
    static let mocks: [NFTItem] = [
        .mockVulcan,
        .mockHelga,
        .mockFlorine,
        .mockOlaf,
        .mockWillow,
        .mockPumpkin
    ]
}

