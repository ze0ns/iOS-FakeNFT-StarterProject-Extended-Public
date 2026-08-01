//
//  ImageLoader.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/8/1.
//
import UIKit

import UIKit

final class ImageLoader {
    
    private let cache = NSCache<NSURL, UIImage>()
    
    init() {}
    
    func loadImage(from url: URL) async throws -> UIImage {
        
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        cache.setObject(image, forKey: url as NSURL)
        
        return image
    }
}
