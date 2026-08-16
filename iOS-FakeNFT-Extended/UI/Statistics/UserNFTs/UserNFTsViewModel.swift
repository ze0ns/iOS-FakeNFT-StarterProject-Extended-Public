//
//  UserNFTsViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 15.08.2026.
//
import Foundation

@MainActor
final class UserNFTsViewModel: ObservableObject {
    enum ViewState {
        case loading
        case loaded([Nft])
        case empty
        case error(String)
    }
    
    @Published private(set) var state: ViewState = .loading
    @Published private(set) var likeIds: [String]
    
    private let service: MyNftService
    private let profileService: ProfileService
    private let onProfileUpdated: (ProfileDTO) -> Void
    
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
    
    // MARK: - Public API (Intents)
    
    func onAppear() {
        if case .loaded = state { return }
        Task { await loadNfts() }
    }
    
    func loadNfts() async {
        state = .loading
        
        do {
            let loadedNfts = try await service.loadNfts(ids: likeIds)
            state = loadedNfts.isEmpty ? .empty : .loaded(loadedNfts)
        } catch {
            state = .error(ProfileErrorMessage.text(for: error))
        }
    }
    
    func toggleFavorite(for nft: Nft) {
        if let index = likeIds.firstIndex(of: nft.id) {
            likeIds.remove(at: index)
        } else {
            likeIds.append(nft.id)
        }
        
        Task {
            do {
               //  отправляем на серер что мы лакнули NFT
            } catch {
                // Если сервер упал, можно откатить изменения лайка,
                // но пока просто оставляем визуальное изменение
            }
        }
    }
}
