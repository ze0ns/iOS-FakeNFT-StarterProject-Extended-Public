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
    
    @State private var image: CGImage?
    
    var body: some View {
        Group {
            if let image {
                Image(
                    image,
                    scale: 1,
                    label: Text("NFT image")
                )
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
            let cgImage = try await imageLoader.loadImage(from: url)
                image = cgImage
        } catch is CancellationError {
        } catch {
            let nsError = error as NSError
            guard nsError.code != NSURLErrorCancelled else {
                return
            }
            print(error)
        }
    }
}
