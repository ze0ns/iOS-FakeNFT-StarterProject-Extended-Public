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
            .navigationTitle(Constants.pay)
            .navigationBarTitleDisplayMode(.inline)
        
        
        Spacer()
        
        VStack {
            webView
            PrimaryButton(title: Constants.pay) {
                
            }
            .padding()
        }
        .background(Color.lightGrayPrimary
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 12,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 12
                )
            )
            .ignoresSafeArea(edges: .bottom))
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
    
    private var webView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Совершая покупку, вы соглашаетесь с условиями")
            
            Link("Пользовательского соглашения", destination: URL(
                string: "https://example.com"
            )!)
            .foregroundStyle(.blue)
            .underline(false)
        }
        .font(.system(size: 13))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

private enum Constants {
    static let paymentMethod = NSLocalizedString("PaymentMethod", comment: "")
    static let pay = NSLocalizedString("Pay", comment: "")
}

#Preview {
    PaymentMethodView(imageLoader: ImageLoader())
}
