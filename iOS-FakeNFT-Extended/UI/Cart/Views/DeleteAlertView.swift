//
//  DeleteAlertView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/30.
//
import SwiftUI

struct DeleteAlertView: View {
    let image: Image
    let onDelete: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            image
                .resizable()
                .scaledToFill()
                .frame(width: 108, height: 108)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("Вы уверены, что хотите\nудалить объект из корзины?")
                .font(.system(size: 17))
                .multilineTextAlignment(.center)

            HStack(spacing: 8) {
                Button {
                    onDelete()
                } label: {
                    Text("Удалить")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.blackPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                Button {
                    onCancel()
                } label: {
                    Text("Вернуться")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.blackPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
        .padding(20)
        .background(Color.whitePrimary)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 24)
    }
}
