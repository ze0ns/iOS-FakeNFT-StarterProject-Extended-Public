//
//  OrdersService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 30.07.2026.
//  для обновления заказа в корзине необходимо отправлять массив с ID NFT
//  nfts: ["b2f44171-7dcd-46d7-a6d3-e2109aacf520", "ca34d35a-4507-47d9-9312-5ea7053994c0", "1464520d-1659-4055-8a79-4593b9569e48"]
//  в ответ вернется модель OrdersModel



import Foundation

protocol OrdersService {
    func loadOrders() async throws -> OrdersModel
    func updateOrders(orders: [String]) async throws -> OrdersModel
}

@MainActor
final class OrdersServiceImpl: OrdersService {

    private let networkClient: NetworkClient
    private let storage: AppStorage

    init(networkClient: NetworkClient, storage: AppStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func loadOrders() async throws -> OrdersModel {
        let request = APIRequest.orders
        let orders: OrdersModel = try await networkClient.send(request: request)
        await storage.saveOrders(orders)
        return orders
    }
    // для обновления заказа в корзине необходимо отправлять массив с ID NFT
    // nfts: ["b2f44171-7dcd-46d7-a6d3-e2109aacf520", "ca34d35a-4507-47d9-9312-5ea7053994c0", "1464520d-1659-4055-8a79-4593b9569e48"]
    // в ответ вернется модель OrdersModel
    func updateOrders(orders: [String]) async throws -> OrdersModel {
        let request = APIRequest.updateOrders(nfts: orders)
        let orders: OrdersModel = try await networkClient.send(request: request)
        await storage.saveOrders(orders)
        return orders
    }
}
