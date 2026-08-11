//
//  SuccessPaymentView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/8/11.
//

import SwiftUI

struct SuccessPaymentView: View {
    @Environment(CartRouter.self) private var router
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Image(.succesfulPayment)
            Text(Constants.succesfulPayment)
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.blackPrimary)
            
            Spacer()
            
            PrimaryButton(title: Constants.backToCart) {
                router.backToCart()
            }
            .padding()
        }
    }
}


private enum Constants {
    static let succesfulPayment = NSLocalizedString("SuccessfulPayment", comment: "")
    static let backToCart = NSLocalizedString("BackToCart", comment: "")
}

#Preview {
    SuccessPaymentView()
        .environment(CartRouter())
}
