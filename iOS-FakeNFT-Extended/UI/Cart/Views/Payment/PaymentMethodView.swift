//
//  PaymentMethodView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/8/8.
//
import SwiftUI

struct PaymentMethodView: View {
    
    var items: [CryptoCurrency] = [.mockAda, .mockApe, .mockBtc, .mockEth]
    
    @State private var selectedItem: CryptoCurrency?
    
    private let imageLoader: ImageLoader
    
    init(imageLoader: ImageLoader) {
        self.imageLoader = imageLoader
    }
    
    var body: some View {
        grid
    }
    
    private var grid: some View {
        LazyVGrid(columns: [GridItem(.flexible()),
                            GridItem(.flexible())],
                  spacing: 7) {
            ForEach(items) { item in
                
                CryptoCurrencyCell(item: item,
                                   imageLoader: imageLoader,
                                   isSelected: selectedItem?.id == item.id)
                .onTapGesture {
                    selectedItem = item
                }
            }
        }
        .padding()
    }
}

#Preview {
    PaymentMethodView(imageLoader: ImageLoader())
}
