//
//  PrimaryButton.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/27.
//

import SwiftUI

struct PrimaryButton: View {
    
    let title: String
    var isEnabled: Bool = true
    let action: () -> Void

    var body: some View {
            Button(action: action) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(isEnabled ? .whitePrimary : .whitePrimary.opacity(0.5))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .cornerRadius(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(isEnabled ? .blackPrimary : .blackPrimary.opacity(0.5))
                    )
                
            }
        
        
            .disabled(!isEnabled)
        }
}

#Preview {
    PrimaryButton(title: "Оплатить", isEnabled: false, action: {})
        .padding()
}
