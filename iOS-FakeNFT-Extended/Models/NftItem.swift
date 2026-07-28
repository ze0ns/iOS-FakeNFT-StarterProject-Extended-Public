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
        
        
      static let mock = NFTItem(name: "Vulcan",
                           imageName: "white_vulcan_1",
                           rating: 2,
                           price: 1.78,
                                currency: .eth,
                           sellerName: "John Doe")
    }

