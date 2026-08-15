//
//  CartCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/28.
//
import SwiftUI

struct CartCell: View {
    let item: NFTItem
    var imageLoader: ImageLoader
    
    var onDeleteTap: (() -> Void)? = nil
    @State private var isFavorite = false
  
    // MARK: - Body
    var body: some View {
        HStack(spacing: 16) {
            CachedAsyncImage(url: item.imageURL, imageLoader: imageLoader)
                .frame(width: 108, height: 108)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.name)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.blackPrimary)
                ratingView
                
                Spacer()
                
                Text(Constants.price)
                    .font(.system(size: 13))
                    .foregroundColor(.blackPrimary)
                
                Text(item.formattedPrice)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.blackPrimary)
                    .lineLimit(1)
                
            }
            .padding(.vertical, 8)
            
            Spacer()
            
            deleteButton
        }
    }
    
    // MARK: - Rating view
    private var ratingView: some View {
        HStack(spacing: 2) {
            ForEach(0..<5, id: \.self) { index in
                Image(systemName: index < item.rating ? SFSymbols.starFill : SFSymbols.star)
                    .font(.system(size: 14))
                    .foregroundColor(.yellow)
            }
        }
    }
    
    // MARK: - Delete Button
    private var deleteButton: some View {
        Button {
            onDeleteTap?()
        } label: {
            Image(.cartDelete)
                .font(.system(size: 20))
                .foregroundColor(.primary)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Constants
private enum Constants {
    static let price = NSLocalizedString("Price", comment: "")
}


// MARK: - Preview
#Preview {
    List {
        CartCell(item: .mockOlaf, imageLoader: ImageLoader())
        CartCell(item: .mockVulcan, imageLoader: ImageLoader())
            .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
}
