//
//  CryptoCurrency.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/27.
//

enum CryptoCurrency: String {
    case btc = "BTC"
    case eth = "ETH"
    case usdt = "USDT"
    case doge = "DOGE"
    case ape = "APE"
    case sol = "SOL"
    case ada = "ADA"
    case shib = "SHIB"

    var displayName: String {
        switch self {
        case .btc: "Bitcoin"
        case .eth: "Ethereum"
        case .usdt: "Tether"
        case .doge: "Dogecoin"
        case .ape: "Apecoin"
        case .sol: "Solana"
        case .ada: "Cardano"
        case .shib: "Shiba Inu"
        }
    }

    var iconName: String {
        rawValue.lowercased() // "btc", "eth" и т.д. — имена ассетов
    }
}


