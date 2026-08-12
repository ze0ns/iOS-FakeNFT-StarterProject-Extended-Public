//
//  CartService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/31.
//
import Foundation

protocol CartServiceProtocol {
    func fetchCartItems() async throws -> [NFTItem]
    func removeItem(id: String) async throws -> [NFTItem]
    func pay(currencyID: String) async throws -> PaymentResponse
}

final class CartService: CartServiceProtocol {
    
    private let nftService: NftService
    private let ordersService: OrdersService
    
    init(
        nftService: NftService,
        ordersService: OrdersService
    ) {
        self.nftService = nftService
        self.ordersService = ordersService
    }
    
    func fetchCartItems() async throws -> [NFTItem] {
        let orders = try await ordersService.loadOrders()
        let nfts = try await nftService.loadArrayNft()
        
        let ids = Set(orders.nfts)
        
        return nfts
            .filter { ids.contains($0.id) }
        
            .map { nft in
                return NFTItem(
                    id: nft.id,
                    name: nft.name,
                    imageURL: URL(string: nft.images.first ?? ""),
                    rating: nft.rating,
                    price: Decimal(nft.price),
                    currency: .mockEth, // используется mock по умолчанию
                    sellerName: nft.author
                )
            }
    }
    
    
    func removeItem(id: String) async throws -> [NFTItem] {
        let orders = try await ordersService.loadOrders()
        
        let updatedIDs = orders.nfts.filter {
            $0 != id
        }
        
        let updatedOrders = try await ordersService.updateOrders(
            orders: updatedIDs
        )
        
        let nfts = try await nftService.loadArrayNft()
        
        let ids = Set(updatedOrders.nfts)
        
        return nfts
            .filter { ids.contains($0.id) }
            .map { nft in
                
                return NFTItem(
                    id: nft.id,
                    name: nft.name,
                    imageURL: URL(string: nft.images.first ?? ""),
                    rating: nft.rating,
                    price: Decimal(nft.price),
                    currency: .mockEth, // используется mock по умолчанию
                    sellerName: nft.author
                )
        }
    }
    
    func pay(currencyID: String) async throws -> PaymentResponse {
            try await ordersService.pay(currencyID: currencyID)
        }
}
