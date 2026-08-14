//
//  CartRoute.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/8/11.
//

import SwiftUI

enum Route: Hashable {
    case payment
    case success
}

@Observable
final class CartRouter {
    var path: [Route] = []
    
    func openPayment() {
        path.append(.payment)
    }
    
    func openSuccess() {
        path.append(.success)
    }
    
    func backToCart() {
        path.removeAll()
    }
}
