//
//  NftItem.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/27.
//
import Foundation

struct NFTItem: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let rating: Int
    let price: Decimal
    let currency: CryptoCurrency
    let sellerName: String?
    
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = ","
        let number = NSDecimalNumber(decimal: price)
        return "\(formatter.string(from: number) ?? "\(price)") \(currency.rawValue)"
    }
}

extension NFTItem {
    
    static let mockVulcan = NFTItem(name: "Vulcan",
                              imageName: "vulcan",
                              rating: 2,
                              price: 1.78,
                              currency: .eth,
                              sellerName: "John Doe")
    
    static let mockHelga = NFTItem(name: "Helga",
                               imageName: "helga",
                               rating: 5,
                               price: 1.22,
                               currency: .eth,
                               sellerName: "John Doe")
    
    static let mockFlorine = NFTItem(name: "Florine",
                               imageName: "florine",
                               rating: 4,
                               price: 1.65,
                               currency: .eth,
                               sellerName: "John Doe")
    
    static let mockOlaf = NFTItem(name: "Olaf",
                              imageName: "olaf",
                              rating: 2,
                              price: 1.78,
                              currency: .eth,
                              sellerName: "John Doe")
    
    static let mockWillow = NFTItem(name: "Willow",
                               imageName: "willow",
                               rating: 5,
                               price: 1.22,
                               currency: .eth,
                               sellerName: "John Doe")
    
    static let mockPumpkin = NFTItem(name: "Pumpkin",
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

