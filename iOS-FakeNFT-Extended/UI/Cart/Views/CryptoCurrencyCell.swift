//
//  CryptoCurrencyCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/8/8.
//
import SwiftUI

struct CryptoCurrencyCell: View {
    let item: CryptoCurrency
    var imageLoader: ImageLoader
    
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        HStack(alignment: .center, spacing: 7) {
            CachedAsyncImage(url: item.imageURL, imageLoader: imageLoader)
                .frame(width: 36, height: 36)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            
            VStack(alignment: .leading) {
                Text(item.name)
                    .foregroundColor(.blackPrimary)
                
                Text(item.title)
                    .foregroundColor(.greenUniversal)
                 
            }
            .font(.system(size: 13, weight: .regular))
            .lineLimit(1)
            
            Spacer()
        }
        .padding(7)
        .frame(height: 46)
        .background(.lightGrayPrimary, in: RoundedRectangle(cornerRadius: 12))
        
    }
}

// MARK: - Preview

#Preview {
    let imageLoader = ImageLoader()
    LazyVGrid(columns: [GridItem(.flexible()),
                        GridItem(.flexible())],
    spacing: 7) {
        CryptoCurrencyCell(item: .mockBTC, imageLoader: imageLoader)
        CryptoCurrencyCell(item: .mockDoge, imageLoader: imageLoader)
        CryptoCurrencyCell(item: .mockUSDT, imageLoader: imageLoader)
        CryptoCurrencyCell(item: .mockApe, imageLoader: imageLoader)
        CryptoCurrencyCell(item: .mockSol, imageLoader: imageLoader)
        CryptoCurrencyCell(item: .mockETH, imageLoader: imageLoader)
        CryptoCurrencyCell(item: .mockAda, imageLoader: imageLoader)
        CryptoCurrencyCell(item: .mockShib, imageLoader: imageLoader)
    }
    .padding()
}
