import Foundation

enum APIRequest {
    case users(page: String)
    case collections
    
    var endpoint: URL? {
        switch self {
        case .users(let page):
            return URL(string: "\(RequestConstants.baseURL)/api/v1/users?page=\(page)&size=10")
        case .collections:
            return URL(string: "\(RequestConstants.baseURL)/api/v1/collections")
        }
    }
}
