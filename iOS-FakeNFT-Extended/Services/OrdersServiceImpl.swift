//
//  OrdersService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 30.07.2026.
//



import Foundation

protocol OrdersService {
    func loadOrders() async throws -> OrdersModel
    func updateOrders(orders: OrdersModel) async throws -> OrdersModel
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
    
    func updateOrders(orders: OrdersModel) async throws -> OrdersModel {
        let request = APIRequest.updateOrders(dto: orders)
        let orders: OrdersModel = try await networkClient.send(request: request)
        await storage.saveOrders(orders)
        return orders
    }
}
