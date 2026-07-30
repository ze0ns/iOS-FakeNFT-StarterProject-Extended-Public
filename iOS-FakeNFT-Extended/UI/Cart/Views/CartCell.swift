//
//  CartCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/28.
//
import SwiftUI

struct CartCell: View {
    let item: NFTItem
    var onDeleteTap: (() -> Void)? = nil
 
    @State private var isFavorite = false
 
    var body: some View {
        HStack(spacing: 16) {
            imageView
 
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
 
    // MARK: Subviews
 
    private var imageView: some View {
        Image(item.imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 108, height: 108)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
 
    private var ratingView: some View {
        HStack(spacing: 2) {
            ForEach(0..<5, id: \.self) { index in
                Image(systemName: index < item.rating ? SFSymbols.starFill : SFSymbols.star)
                    .font(.system(size: 14))
                    .foregroundColor(.yellow)
            }
        }
    }
 
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

private enum Constants {
    static let price = NSLocalizedString("Price", comment: "")
}

 
// MARK: - Preview
 
#Preview {
    List {
        CartCell(item: .mockOlaf)
        CartCell(item: .mockVulcan)
            .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
}
