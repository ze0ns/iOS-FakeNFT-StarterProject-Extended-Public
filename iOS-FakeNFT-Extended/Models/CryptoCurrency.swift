//
//  CryptoCurrency.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/27.
//
import Foundation

struct CryptoCurrency: Sendable {
    let title: String
    let name: String
    let imageURL: URL?
    let id: String
    
}

extension CryptoCurrency {
    
    static let mockBTC = CryptoCurrency(title: "BTC",
                                            name: "Bitcoin",
                                        imageURL: nil,
                                            id: "Bitcoin")
    
    static let mockETH = CryptoCurrency(title: "ETH",
                                            name: "Ethereum",
                                        imageURL: nil,
                                            id: "Ethereum")
    
    
    static let mockUSDT = CryptoCurrency(title: "USDT",
                                         name: "Tether",
                                         imageURL: nil,
                                         id: "Tether")
    
    static let mockDoge = CryptoCurrency(title: "DOGE",
                                         name: "Dogecoin",
                                         imageURL: nil,
                                         id: "Dogecoin")
    
    static let mockApe = CryptoCurrency(title: "APE",
                                        name: "Apecoin",
                                        imageURL: nil,
                                        id: "Apecoin")
    
    static let mockSol = CryptoCurrency(title: "SOL",
                                        name: "Solana",
                                        imageURL: nil,
                                        id: "Solana")
    
    static let mockAda = CryptoCurrency(title: "ADA",
                                        name: "Cardano",
                                        imageURL: nil,
                                        id: "Cardano")
    
    static let mockShib = CryptoCurrency(title: "SHIB",
                                         name: "Shiba Inu",
                                         imageURL: nil,
                                         id: "Shiba Inu")
    
}

