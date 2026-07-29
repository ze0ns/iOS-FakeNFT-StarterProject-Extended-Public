import Foundation

import Foundation

enum APIRequest: NetworkRequest {
    case users(page: String)
    case nft(id: String)
    case collections
    case collectionsByID(id: String)
    
    private var baseURL: String {
        RequestConstants.baseURL
    }
    
    
    private var path: String {
        switch self {
        case .users:
            return "/api/v1/users"
        case .nft(let id):
            return "/api/v1/nft/\(id)"
        case .collections:
            return "/api/v1/collections"
        case .collectionsByID(let id):
            return "/api/v1/collections/\(id)"
        }
    }
    
    var endpoint: URL? {
        switch self {
        case .users(let page):
            var components = URLComponents(string: "\(baseURL)\(path)")
            components?.queryItems = [
                URLQueryItem(name: "page", value: page),
                URLQueryItem(name: "size", value: "10")
            ]
            return components?.url
            
        case .nft, .collections, .collectionsByID:
            return URL(string: "\(baseURL)\(path)")
        }
    }
}
