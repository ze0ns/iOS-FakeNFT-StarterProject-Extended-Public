import Foundation
struct ProfileUpdateDTO: Encodable {
    let likes: String
    let avatar: String
    let name: String
    let description: String
}
enum APIRequest: NetworkRequest {
    case users(page: String)
    case nft(id: String)
    case arrayNft(page: String)
    case collections
    case collectionsByID(id: String)
    case currencies
    case profile
    case updateProfileInfo(likes: [String], avatar: String, name: String, description: String)
    case orders
    case updateOrders(nfts: [String])
    case payOrders(dto: any Encodable)
    
    private var baseURL: String {
        RequestConstants.baseURL
    }
    
    
    private var path: String {
        switch self {
        case .users:
            return "/api/v1/users"
        case .nft(let id):
            return "/api/v1/nft/\(id)"
        case .arrayNft:
            return "/api/v1/nft"
        case .collections:
            return "/api/v1/collections"
        case .collectionsByID(let id):
            return "/api/v1/collections/\(id)"
        case .currencies:
            return "/api/v1/currencies"
        case .profile,.updateProfileInfo:
            return "/api/v1/profile/1"
        case .orders, .updateOrders, .payOrders:
            return "/api/v1/orders/1"
        }
    }
    // Переопределяем httpMethod
    var httpMethod: HttpMethod {
        switch self {
        case .updateProfileInfo, .updateOrders:
            return .put
        default:
            return .get
        }
    }
    var dto: Encodable? {
        switch self {
        case .payOrders(let dto) :
            return dto
        case .updateProfileInfo(let likes, let avatar, let name, let description):
            // Склеиваем массив лайков в строку через запятую.
            // Пробелы после запятой лучше не добавлять, чтобы не было проблем с парсингом на сервере.
            let likesString = likes.joined(separator: ",")
            return ProfileUpdateDTO(
                likes: likesString,
                avatar: avatar,
                name: name,
                description: description
            )

        case .updateOrders(let nfts):
            let nftsString = nfts.joined(separator: ", ")
            return "nfts=\(nftsString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        default:
            return nil
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
            
        case .arrayNft(let page):
            var components = URLComponents(string: "\(baseURL)\(path)")
            components?.queryItems = [
                URLQueryItem(name: "page", value: page),
                URLQueryItem(name: "size", value: "10")
            ]
            return components?.url
            
        case .nft, .collections, .collectionsByID, .currencies, .profile, .updateProfileInfo, .orders, .updateOrders, .payOrders:
            return URL(string: "\(baseURL)\(path)")
        }
    }
}

