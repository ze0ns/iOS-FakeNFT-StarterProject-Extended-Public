//
//  TabPlaceholderView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 31.07.2026.
//


//
//  TabPlaceholderView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 28.07.2026.
//

import SwiftUI

struct TabPlaceholderView: View {

    let title: String
    let systemImage: String

    var body: some View {
        ContentUnavailableView(title, systemImage: systemImage)
    }
}

#Preview {
    TabPlaceholderView(title: "Корзина", systemImage: "bag.fill")
}
