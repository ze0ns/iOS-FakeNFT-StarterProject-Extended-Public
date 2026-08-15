//
//  UserNFTsViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 15.08.2026.
//
//
//  UserNFTsViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 15.08.2026.
//

import Foundation
import SwiftUI

@MainActor
final class UserNFTsViewModel: ObservableObject {
    
    // Источники истины для View — должны быть @Published
    @Published var nfts: [Nft] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // Внутренний state (если используется где-то в логике)
    private(set) var state: NftListState = .loading
    
    private let service: MyNftService
    private let profileService: ProfileService
    private let onProfileUpdated: (ProfileDTO) -> Void
    private var likeIds: [String]
    
    init(
        likeIds: [String],
        service: MyNftService,
        profileService: ProfileService,
        onProfileUpdated: @escaping (ProfileDTO) -> Void
    ) {
        self.likeIds = likeIds
        self.service = service
        self.profileService = profileService
        self.onProfileUpdated = onProfileUpdated
    }
    
    // MARK: - Public API
    
    func onAppear() {
        // Загружаем только если список пуст и не идёт загрузка
        guard nfts.isEmpty, !isLoading else { return }
        Task { await loadNfts() }
    }
    
    func loadNfts() async {
        isLoading = true
        state = .loading
        errorMessage = nil
        
        do {
            let loadedNfts = try await service.loadNfts(ids: likeIds)
            self.nfts = loadedNfts          // <-- обновляем @Published
            self.state = .success(loadedNfts)
        } catch {
            let message = ProfileErrorMessage.text(for: error)
            self.errorMessage = message
            self.state = .error(message)
        }
        
        isLoading = false                    // <-- обновляем @Published
    }
    
    // MARK: - Actions
    
    func toggleFavorite(for nft: Nft) {
        // Удаляем/добавляем id в likeIds и уведомляем через callback
        if let index = likeIds.firstIndex(of: nft.id) {
            likeIds.remove(at: index)
        } else {
            likeIds.append(nft.id)
        }
        
        Task {
            // Обновляем профиль на сервере и уведомляем родителя
            // await profileService.updateLikes(likeIds)
            // onProfileUpdated(updatedProfile)
            
            // Перезагружаем список, чтобы UI был актуален
            await loadNfts()
        }
    }
}
