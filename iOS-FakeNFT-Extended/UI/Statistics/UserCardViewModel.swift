//
//  UserCardViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 15.08.2026.
//


import Foundation
import SwiftUI

@MainActor
final class UserCardViewModel: ObservableObject {
    
    // MARK: - Published States
    
    @Published var userInfo: UserModelElement?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - Dependencies
    
     let userId: String
     let usersInfoService: UsersInfoService
     let nftService: MyNftService
     let profileService: ProfileService
     let onProfileUpdated: (ProfileDTO) -> Void
    
    // MARK: - Init
    
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
    
    // MARK: - Public API
    
    func loadUserInfo() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let info = try await usersInfoService.loadUserInfoById(id: userId)
            self.userInfo = info
        } catch {
            self.errorMessage = "Не удалось загрузить данные пользователя"
            print("Error loading user info: \(error)")
        }
        
        isLoading = false
    }
    
    func refresh() async {
        await loadUserInfo()
    }
}
