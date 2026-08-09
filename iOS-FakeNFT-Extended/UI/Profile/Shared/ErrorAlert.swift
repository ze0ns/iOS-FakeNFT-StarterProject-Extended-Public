//
//  ErrorAlert.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 06.08.2026.
//

import SwiftUI

extension View {

    /// Показывает алерт, пока у экрана есть текст ошибки.
    func errorAlert(message: String?, onDismiss: @escaping () -> Void) -> some View {
        let isPresented = Binding(
            get: { message != nil },
            set: { presented in
                guard !presented else { return }
                onDismiss()
            }
        )

        return alert(
            NSLocalizedString(ProfileStrings.errorTitle, comment: ""),
            isPresented: isPresented
        ) {
            Button(NSLocalizedString(ProfileStrings.close, comment: ""), action: onDismiss)
        } message: {
            Text(message ?? "")
        }
    }
}
