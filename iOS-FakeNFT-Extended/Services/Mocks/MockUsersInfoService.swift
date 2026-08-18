//
//  MockUsersInfoService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 15.08.2026.
//
import SwiftUI

final class MockUsersInfoService: UsersInfoService {
    enum Behavior {
        case success
        case delayed
        case failure
        case paginated
    }
    
    let behavior: Behavior
    
    init(behavior: Behavior = .success) {
        self.behavior = behavior
    }
    
    func loadUsersInfo(page: String) async throws -> UsersModel {
        switch behavior {
        case .delayed:
            try await Task.sleep(for: .seconds(1.5))
            return makeUsersModel(page: page)
            
        case .success:
            return makeUsersModel(page: page)
            
        case .failure:
            try await Task.sleep(for: .milliseconds(300))
            throw URLError(.notConnectedToInternet)
            
        case .paginated:
            try await Task.sleep(for: .milliseconds(800))
            let pageNum = Int(page) ?? 1
            if pageNum > 3 {
                return UsersModel([])  // ✅ Без label
            }
            return makeUsersModel(page: page)
        }
    }
    
    func loadUserInfoById(id: String) async throws -> UserModelElement {
        try await Task.sleep(for: .milliseconds(300))
        return Self.mockUser(id: id)
    }
    
    private func makeUsersModel(page: String) -> UsersModel {
        let pageNum = Int(page) ?? 1
        let users: [UserModelElement] = (1...5).map { index in
            let globalIndex = (pageNum - 1) * 5 + index
            return UserModelElement(
                name: "Пользователь №\(globalIndex)",
                avatar: "https://i.pravatar.cc/150?img=\(globalIndex)",
                description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT.",
                website: "https://practicum.yandex.ru/devops/",
                nfts: [
                    "ca34d35a-4507-47d9-9312-5ea7053994c0",
                    "1464520d-1659-4055-8a79-4593b9569e48"
                ],
                rating: "\(Int.random(in: 100...2000))",
                id: "user-\(globalIndex)"
            )
        }
        return UsersModel(users)  // ✅ Без label
    }
    
    static func mockUser(id: String) -> UserModelElement {
        UserModelElement(
            name: "Helga Storm",
            avatar: "https://i.pravatar.cc/150?img=1",
            description: "Digital artist & NFT collector.",
            website: "https://practicum.yandex.ru/",
            nfts: ["nft-1", "nft-2"],
            rating: "1234",
            id: id
        )
    }
}
