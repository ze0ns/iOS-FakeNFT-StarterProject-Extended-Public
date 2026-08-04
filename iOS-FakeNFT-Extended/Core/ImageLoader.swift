//
//  ImageLoader.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/8/1.
//
import SwiftUI

import SwiftUI
import ImageIO

actor ImageLoader {
    
    private let cache = NSCache<NSURL, CGImageBox>()
    
    init() {}
    
    func loadImage(from url: URL) async throws -> CGImage {
        
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage.image
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let source = CGImageSourceCreateWithData(
            data as CFData,
            nil
        ),
        let cgImage = CGImageSourceCreateImageAtIndex(
            source,
            0,
            nil
        ) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        cache.setObject(
            CGImageBox(cgImage),
            forKey: url as NSURL
        )
        
        return cgImage
    }
}

private final class CGImageBox {
    let image: CGImage
    
    init(_ image: CGImage) {
        self.image = image
    }
}
