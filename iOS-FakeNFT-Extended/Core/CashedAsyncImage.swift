//
//  CashedAsyncImage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/8/1.
//
import SwiftUI

struct CachedAsyncImage: View {
    
    let url: URL?
    let imageLoader: ImageLoader
    
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
            } else if let url {
                ProgressView()
                    .task {
                        await fetchImage(from: url)
                    }
            } else {
                Image(systemName: "photo")
                    .resizable()
            }
        }
    }
    
    private func fetchImage(from url: URL) async {
        do {
            image = try await imageLoader.loadImage(from: url)
        } catch {
            print(error)
        }
    }
}
