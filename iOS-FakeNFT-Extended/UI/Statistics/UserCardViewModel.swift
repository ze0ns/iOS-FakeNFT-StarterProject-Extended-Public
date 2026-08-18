//
//  UserCardViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 15.08.2026.
//


import Foundation

@MainActor
final class UserCardViewModel: ObservableObject {
    
    enum State {
        case loading
        case loaded(UserModelElement)
        case error(String)
    }
    
    @Published private(set) var state: State = .loading
    
    private let userId: String
    private let usersInfoService: UsersInfoService
  
    let nftService: MyNftService
    let profileService: ProfileService
    let onProfileUpdated: (ProfileDTO) -> Void
    
    init(
        userId: String,
        usersInfoService: UsersInfoService,
        nftService: MyNftService,
        profileService: ProfileService,
        onProfileUpdated: @escaping (ProfileDTO) -> Void
    ) {
        self.userId = userId
        self.usersInfoService = usersInfoService
        self.nftService = nftService
        self.profileService = profileService
        self.onProfileUpdated = onProfileUpdated
    }
    
    func loadUserInfo() async {
        state = .loading
        
        do {
            let info = try await usersInfoService.loadUserInfoById(id: userId)
            state = .loaded(info)
        } catch {
            state = .error("Не удалось загрузить данные пользователя")
        }
    }
}
