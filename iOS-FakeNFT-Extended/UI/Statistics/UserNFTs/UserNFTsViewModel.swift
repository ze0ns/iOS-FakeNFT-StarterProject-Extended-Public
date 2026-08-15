//
//  UserNFTsViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Oschepkov Aleksandr on 15.08.2026.
//
import Foundation

@MainActor
final class UserNFTsViewModel: ObservableObject {
    
    // Единый State для View
    enum ViewState {
        case loading
        case loaded([Nft])
        case empty
        case error(String)
    }
    
    @Published private(set) var state: ViewState = .loading
    
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
        guard case var .loaded(currentNfts) = state else { return }
        if let index = likeIds.firstIndex(of: nft.id) {
            likeIds.remove(at: index)
            currentNfts.removeAll { $0.id == nft.id }
        } else {
            likeIds.append(nft.id)
        }
        state = .loaded(currentNfts)
        
        Task {
            do {
                // let updatedProfile = try await profileService.updateLikes(likeIds)
                // onProfileUpdated(updatedProfile)
            } catch {
                // Если сервер упал, откатываем изменения
                await loadNfts()
            }
        }
    }
}
