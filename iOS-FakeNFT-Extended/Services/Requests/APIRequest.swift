//
//  APIRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 28.07.2026.
//

import Foundation

enum APIRequest: NetworkRequest {
    case users(page: String)
    case userInfoByID(id: String)
    case nft(id: String)
    case arrayNft(page: String)
    case collections
    case collectionsByID(id: String)
    case currencies
    case currenciesByID(id: String)
    case currenciesSetBeforePay(id: String)
    case profile
    case updateProfile(dto: ProfileModel)
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
        case .userInfoByID(let id):
            return "/api/v1/users/\(id)"
        case .arrayNft:
            return "/api/v1/nft"
        case .collections:
            return "/api/v1/collections"
        case .collectionsByID(let id):
            return "/api/v1/collections/\(id)"
        case .currencies:
            return "/api/v1/currencies"
        case .currenciesByID(let id):
            return "/api/v1/currencies/\(id)"
        case .currenciesSetBeforePay(let id):
            return "/api/v1/orders/1/payment/\(id)"
        case .profile, .updateProfile:
            return "/api/v1/profile/1"
        case .orders, .updateOrders, .payOrders:
            return "/api/v1/orders/1"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .updateProfile, .updateOrders:
            return .put
        default:
            return .get
        }
    }
    
    var dto: Encodable? {
        switch self {
        case .updateProfile(let dto):
            return dto
        case .payOrders(let dto):
            return dto
        case .updateOrders(let nfts):
            // Возвращаем структуру, а не сырую строку
            return UpdateOrdersDTO(nfts: nfts.joined(separator: ", "))
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
            
        default:
            return URL(string: "\(baseURL)\(path)")
        }
    }
}


